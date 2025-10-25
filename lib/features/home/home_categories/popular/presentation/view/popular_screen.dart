import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';
import 'package:gazzer/features/home/home_categories/popular/domain/top_items_repo.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_cubit.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});
  static const route = '/popular-screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopItemsCubit(
        di.get<TopItemsRepo>(),
      )..getTopItems(),
      child: Scaffold(
        appBar: const MainAppBar(showCart: false, iconsColor: Co.secondary),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<TopItemsCubit, TopItemsStates>(
          builder: (context, state) {
            if (state is TopItemsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TopItemsErrorState) {
              return FailureComponent(
                message: state.message,
                onRetry: () {
                  context.read<TopItemsCubit>().getTopItems();
                },
              );
            }

            if (state is TopItemsSuccessState) {
              return _buildContent(context, state.data, state.isFromCache);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, data, bool isFromCache) {
    final items = data?.entities ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeCategoriesHeader(
          onChange: (value) {},
        ),
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(
            text: L10n.tr().suggestedForYou,
            style: TStyle.blackBold(16),
          ),
        ),
        // const VerticalSpacing(12),
        // SizedBox(
        //   height: 180,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     padding: AppConst.defaultHrPadding,
        //     itemCount: items.length > 5 ? 5 : items.length,
        //     separatorBuilder: (context, index) => const HorizontalSpacing(12),
        //     itemBuilder: (context, index) {
        //       final item = items[index];
        //       return VerticalRotatedImgCard(
        //         prod: _convertToProductEntity(item),
        //         onTap: () {
        //           PlateDetailsRoute(id: item.item?.id ?? 0).push(context);
        //         },
        //       );
        //     },
        //   ),
        // ),
        const VerticalSpacing(16),
        Expanded(
          child: GridView.builder(
            padding: AppConst.defaultPadding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return VerticalRotatedImgCard(
                prod: _convertToProductEntity(item),
                onTap: () {
                  PlateDetailsRoute(id: item.item?.id ?? 0).push(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Convert TopItemEntity to ProductEntity for VerticalRotatedImgCard
  ProductEntity _convertToProductEntity(item) {
    return ProductEntity(
      id: item.item?.id ?? 0,
      name: item.item?.plateName ?? '',
      description: item.item?.plateDescription ?? '',
      price: double.tryParse(item.item?.price ?? '0') ?? 0.0,
      image: item.item?.plateImage ?? '',
      rate: double.tryParse(item.item?.rate ?? '0') ?? 0.0,
      reviewCount: item.item?.rateCount ?? 0,
      outOfStock: false,
    );
  }
}
