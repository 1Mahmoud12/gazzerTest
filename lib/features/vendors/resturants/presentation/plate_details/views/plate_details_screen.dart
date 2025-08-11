import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/components/ordered_with_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/plate_options_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_image_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_summary_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'plate_details_screen.g.dart';

@TypedGoRoute<PlateDetailsRoute>(path: SinglePlateScreen.route)
@immutable
class PlateDetailsRoute extends GoRouteData with _$PlateDetailsRoute {
  const PlateDetailsRoute({required this.id, this.$extra});
  final int id;
  final CartItemEntity? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<PlateDetailsCubit>(param1: id),
      child: SinglePlateScreen(itemToEdit: $extra),
    );
  }
}

class SinglePlateScreen extends StatelessWidget {
  static const route = '/single-plate';
  const SinglePlateScreen({super.key, this.itemToEdit});
  final CartItemEntity? itemToEdit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlateDetailsCubit, PlateDetailsStates>(
      builder: (context, detailsState) {
        if (detailsState is PlateDetailsError) {
          return Scaffold(
            appBar: MainAppBar(showBadge: true, showCart: true, onShare: () {}),
            body: FailureComponent(
              message: L10n.tr().couldnotLoadDataPleaseTryAgain,
              onRetry: () => context.read<PlateDetailsCubit>().loadPlateDetails(),
            ),
          );
        } else if (detailsState is PlateDetailsLoaded) {
          return BlocProvider(
            create: (context) => di<AddToCartCubit>(param1: (detailsState.plate, detailsState.options), param2: itemToEdit),
            child: Builder(
              builder: (context) {
                final cubit = context.read<AddToCartCubit>();
                final canPop = ValueNotifier(true);

                return ValueListenableBuilder(
                  valueListenable: canPop,
                  builder: (context, value, child) => PopScope(
                    canPop: Session().client == null || value,
                    onPopInvokedWithResult: (didPop, result) {
                      if (!didPop) {
                        showDialog<bool>(
                          context: context,
                          builder: (context) => Dialogs.confirmDialog(
                            title: L10n.tr().alert,
                            context: context,
                            okBgColor: Colors.redAccent,
                            message: L10n.tr().yourChoicesWillBeClearedBecauseYouDidntAddToCart,
                          ),
                        ).then((confirmed) {
                          if (confirmed == true) {
                            canPop.value = true;
                            if (context.mounted) context.pop();
                          }
                        });
                      }
                    },
                    child: child!,
                  ),
                  child: Scaffold(
                    appBar: MainAppBar(showBadge: true, showCart: true, onShare: () {}),
                    body: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      children: [
                        ProductImageWidget(image: detailsState.plate.image, plate: detailsState.plate),
                        ProductSummaryWidget(plate: detailsState.plate),
                        const VerticalSpacing(24),
                        BlocConsumer<AddToCartCubit, AddToCartStates>(
                          listener: (context, state) {
                            canPop.value = !state.hasUserInteracted;
                            if (state.status == ApiStatus.success) {
                              Alerts.showToast(state.message, error: false);
                              context.pop(true); // ** to declare that the cart has changed
                            } else if (state.status == ApiStatus.error) {
                              Alerts.showToast(state.message);
                            }
                          },
                          builder: (context, cartState) {
                            return Column(
                              children: List.generate(detailsState.options.length, (index) {
                                final detailsOption = detailsState.options[index];
                                return PlateOptionsWidget(
                                  option: detailsState.options[index],
                                  selectedId: cartState.selectedOptions[detailsOption.id] ?? {},
                                  onValueSelected: (id) => cubit.setOptionValue(detailsOption.id, id),
                                );
                              }),
                            );
                          },
                        ),
                        const VerticalSpacing(24),
                        OrderedWithComponent(
                          products: detailsState.orderedWith,
                          title: L10n.tr().alsoOrderWith,
                          type: CartItemType.restaurantItem,
                        ),
                        const VerticalSpacing(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<AddToCartCubit, AddToCartStates>(
                              buildWhen: (previous, current) => previous.note != current.note,
                              builder: (context, state) => AddSpecialNote(
                                note: state.note,
                                onNoteChange: (note) => cubit.setNote(note),
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacing(16),
                      ],
                    ),
                    bottomNavigationBar: Skeleton.shade(
                      child: BlocBuilder<AddToCartCubit, AddToCartStates>(
                        builder: (context, cartState) {
                          return ProductPriceSummary(
                            isLoading: cartState.status == ApiStatus.loading,
                            price: cartState.totalPrice,
                            quantity: cartState.quantity,
                            onChangeQuantity: (isAdding) {
                              if (isAdding) return cubit.increment();
                              return cubit.decrement();
                            },
                            onsubmit: cubit.addToCart,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Scaffold(
          appBar: MainAppBar(),
          body: Center(child: AdaptiveProgressIndicator()),
        );
      },
    );
  }
}
