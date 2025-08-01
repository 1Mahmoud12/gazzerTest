import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_extras_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/widgets/product_details_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'product_details_screen.g.dart';

@TypedGoRoute<ProductDetailsRoute>(path: ProductDetailsScreen.route)
@immutable
class ProductDetailsRoute extends GoRouteData with _$ProductDetailsRoute {
  const ProductDetailsRoute({required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<ProductDetailsCubit>(param1: productId),
      child: ProductDetailsScreen(productId: productId),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  static const route = '/product-details';
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(showCart: true, onShare: () {}, showNotification: false),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsError) {
            return FailureWidget(
              message: state.message,
              onRetry: () => context.read<ProductDetailsCubit>().loadProductDetails(),
            );
          }

          return Skeletonizer(
            enabled: state is ProductDetailsLoading,
            child: ListView(
              children: [
                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: Text(state.product.name, style: TStyle.primaryBold(20)),
                ),
                ProductDetailsWidget(
                  product: state.product,
                ),
                const VerticalSpacing(16),

                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: Column(
                    children: [
                      OrderedWithComponent(products: Fakers.plateOrderedWith),
                      const VerticalSpacing(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AddSpecialNote(
                            onNoteChange: (note) {
                              // Handle note change if needed
                            },
                          ),
                        ],
                      ),
                      const VerticalSpacing(16),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is ProductDetailsLoading,
            child: const ProductPriceSummary(),
          );
        },
      ),
    );
  }
}
