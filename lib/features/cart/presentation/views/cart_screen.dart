import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/component/cart_address_component.dart';
import 'package:gazzer/features/cart/presentation/views/component/scheduling_component.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_summary_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/empty_cart_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/vendor_cart_products_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const route = '/cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartCubit cubit;

  @override
  void initState() {
    cubit = context.read<CartCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Session().client != null && mounted) cubit.loadCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartStates>(
      listenWhen: (previous, current) => current is BaseErrorState && previous is! BaseErrorState,
      listener: (context, state) {
        if (state is BaseErrorState) Alerts.showToast((state as BaseErrorState).message);
      },
      child: Scaffold(
        appBar: const MainAppBar(isCartScreen: true),
        body: Column(
          children: [
            GradientText(
              text: L10n.tr().cart,
              style: TStyle.blackBold(24),
              gradient: Grad().radialGradient.copyWith(radius: 2, center: Alignment.centerLeft),
            ),
            if (Session().client == null)
              Expanded(child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseCart))
            else
              Expanded(
                child: BlocBuilder<CartCubit, CartStates>(
                  buildWhen: (previous, current) => current is FullCartStates,
                  builder: (context, state) {
                    if (state is! FullCartStates) return const SizedBox.shrink();
                    if (state is FullCartError) {
                      return FailureComponent(
                        message: state.message,
                        onRetry: () => cubit.loadCart(),
                      );
                    } else if (state is FullCartLoaded && state.vendors.isEmpty) {
                      return const EmptyCartWidget();
                    }
                    return RefreshIndicator(
                      onRefresh: () => cubit.loadCart(),
                      child: Skeletonizer(
                        enabled: state is FullCartLoading,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: state.vendors.length + 2,
                          separatorBuilder: (context, index) => const VerticalSpacing(24),
                          // const Divider(indent: 16, color: Colors.black38, endIndent: 16, height: 33),
                          itemBuilder: (context, index) {
                            if (index == state.vendors.length) return const CartAddressComponent();
                            if (index == state.vendors.length + 1) return const SchedulingComponent();
                            // if (index == state.vendors.length + 2) return const CartSummaryWidget();

                            return VendorCartProductsItem(cartVendor: state.vendors[index]);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: Session().client == null ? null : const CartSummaryWidget(),
      ),
    );
  }
}
