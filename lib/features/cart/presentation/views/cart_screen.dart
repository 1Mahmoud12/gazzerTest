import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/component/cart_address_component.dart';
import 'package:gazzer/features/cart/presentation/views/component/scheduling_component.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/empty_cart_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/notes_card_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/vendor_cart_products_item.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_cubit.dart';
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/order_summary_widget.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const route = '/cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen> {
  late final CartCubit cubit;

  @override
  void initState() {
    cubit = context.read<CartCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Session().client != null && mounted) cubit.loadCart();
    });
    context.read<CheckoutCubit>().applyVoucher(null);

    super.initState();
  }

  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // 👈 keeps state alive

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<CartCubit, CartStates>(
      listenWhen: (previous, current) => current is BaseErrorState && previous is! BaseErrorState,
      listener: (context, state) {
        if (state is UpdateItemError && state.needsNewPouchApproval) {
          return;
        }
        if (state is BaseErrorState) {
          Alerts.showToast((state as BaseErrorState).message);
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: L10n.tr().cart,
          onShare: () async {
            animationDialogLoading();
            final result = await ShareService().generateShareLink(
              type: ShareEnumType.cart.name,
              shareableType: ShareEnumType.cart.name,
              shareableId: '',
            );
            closeDialog();
            switch (result) {
              case Ok<ShareGenerateResponse>(value: final response):
                await Clipboard.setData(ClipboardData(text: response.shareLink));
                if (context.mounted) {
                  Alerts.showToast(L10n.tr().link_copied_to_clipboard, error: false);
                }
              case Err<ShareGenerateResponse>(error: final error):
                if (context.mounted) {
                  Alerts.showToast(error.message);
                }
            }
          },

          onBack: () {
            context.go(HomeScreen.route);
          },
        ),
        body: Column(
          children: [
            if (Session().client == null)
              Expanded(child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseCart))
            else
              Expanded(
                child: BlocBuilder<CartCubit, CartStates>(
                  buildWhen: (previous, current) => current is FullCartStates,
                  builder: (context, state) {
                    if (state is! FullCartStates) {
                      return const SizedBox.shrink();
                    }
                    if (state is FullCartError) {
                      return FailureComponent(message: state.message, onRetry: () => cubit.loadCart());
                    } else if (state is FullCartLoaded && state.vendors.isEmpty) {
                      return const EmptyCartWidget();
                    }
                    return RefreshIndicator(
                      onRefresh: () => cubit.loadCart(),
                      child: Skeletonizer(
                        enabled: state is FullCartLoading,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                          return Dialogs.confirmDialog(
                                            title: L10n.tr().warning,
                                            message: L10n.tr().areYouSureYouWantToDeleteAllCart,
                                            okBgColor: Co.darkRed,
                                            context: context,
                                          );
                                        },
                                      );
                                      if (confirmed == true) {
                                        cubit.removeFromCartByType('all', 0);
                                      }
                                    },
                                    child: Text(L10n.tr().remove_all, style: TStyle.robotBlackMedium().copyWith(color: Co.darkRed)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 24),
                                itemCount: state.vendors.length + 7,
                                separatorBuilder: (context, index) => const VerticalSpacing(24),
                                // const Divider(indent: 16, color: Colors.black38, endIndent: 16, height: 33),
                                itemBuilder: (context, index) {
                                  if (index == state.vendors.length) {
                                    return const CartAddressComponent();
                                  }
                                  if (index == state.vendors.length + 1) {
                                    return const SchedulingComponent();
                                  }
                                  if (index == state.vendors.length + 2) {
                                    return NotesCartWidget(notesController: _notesController);
                                  }
                                  if (index == state.vendors.length + 3) {
                                    if (Session().client == null) return null;
                                    // Provide VouchersCubit scope for VoucherWidget and load vouchers when cart screen opens
                                    return BlocProvider(create: (context) => di<VouchersCubit>()..loadVouchers(), child: const VoucherWidget());
                                  }
                                  if (index == state.vendors.length + 4) {
                                    return Session().client == null ? null : const OrderSummaryWidget();
                                  }
                                  if (index == state.vendors.length + 5) {
                                    return Row(
                                      spacing: 12,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius: AppConst.defaultInnerBorderRadius,
                                              border: GradientBoxBorder(
                                                gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: MainBtn(
                                                onPressed: () {
                                                  context.go(HomeScreen.route);
                                                },
                                                text: L10n.tr().continueShopping,
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                width: double.infinity,
                                                height: 0,
                                                borderColor: Co.purple,
                                                textStyle: TStyle.blackRegular(16),
                                                bgColor: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius: AppConst.defaultInnerBorderRadius,
                                              border: GradientBoxBorder(
                                                gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: MainBtn(
                                                onPressed: () {
                                                  if (!state.isCartValid) {
                                                    Alerts.showToast(L10n.tr().needToAddAddressFirst);
                                                    return;
                                                  }
                                                  context.push(ConfirmOrderScreen.route);
                                                },
                                                disabledColor: Co.grey.withAlpha(80),

                                                text: L10n.tr().checkout,
                                                textStyle: TStyle.whiteRegular(16),
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                bgColor: Co.purple,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  if (index == state.vendors.length + 6) {
                                    return Session().client == null ? null : const VerticalSpacing(70);
                                  }
                                  // if (index == state.vendors.length + 2) return const CartSummaryWidget();

                                  return VendorCartProductsItem(cartVendor: state.vendors[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
