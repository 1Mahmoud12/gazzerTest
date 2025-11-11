import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';
import 'package:gazzer/features/home/home_categories/popular/data/dtos/top_items_dto.dart';
import 'package:gazzer/features/home/home_categories/popular/domain/top_items_repo.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_cubit.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});
  static const route = '/popular-screen';

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  String _searchQuery = '';
  List<TopItemEntity> _allItems = [];
  List<TopItemEntity> _filteredItems = [];

  void _onSearchChanged(String value) {
    if (!context.mounted) return;

    setState(() {
      _searchQuery = value;
      if (value.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) {
          final itemData = item.item;
          if (itemData == null) return false;
          return (itemData.plateName?.toLowerCase().contains(
                    value.toLowerCase(),
                  ) ??
                  false) ||
              (itemData.plateDescription?.toLowerCase().contains(
                    value.toLowerCase(),
                  ) ??
                  false);
        }).toList();
      }
    });
  }

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeCategoriesHeader(
              onChange: _onSearchChanged,
            ),
            Expanded(
              child: BlocBuilder<TopItemsCubit, TopItemsStates>(
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
                    // Store all items for local filtering
                    if (_allItems.isEmpty) {
                      _allItems = state.data?.entities ?? [];
                      _filteredItems = _allItems;
                    }

                    return _buildContent(
                      context,
                      _filteredItems,
                      state.isFromCache,
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<TopItemEntity> items,
    bool isFromCache,
  ) {
    if (items.isEmpty) {
      return FailureComponent(
        message: _searchQuery.isEmpty ? L10n.tr().noData : L10n.tr().noSearchResults,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(
            text: L10n.tr().bestPopular,
            style: TStyle.blackBold(16),
          ),
        ),
        const VerticalSpacing(16),
        Expanded(
          child: GridView.builder(
            padding: AppConst.defaultPadding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final TopItemEntity item = items[index];
              ItemType type = ItemType.plate;

              return VerticalRotatedImgCard(
                prod: _convertToProductEntity(item, type),
                onTap: () {
                  if (type == ItemType.plate) {
                    PlateDetailsRoute(
                      id: item.item?.id ?? 0,
                    ).push(context);
                  } else if (type == ItemType.product) {
                    ProductDetailsRoute(
                      productId: item.item?.id ?? 0,
                    ).push(context);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Convert TopItemEntity to ProductEntity for VerticalRotatedImgCard
  GenericItemEntity _convertToProductEntity(TopItemEntity item, ItemType type) {
    if (type == ItemType.plate) {
      return PlateEntity(
        id: item.item?.id ?? 0,
        name: item.item?.plateName ?? '',
        description: item.item?.plateDescription ?? '',
        price: double.tryParse(item.item?.price ?? '0') ?? 0.0,
        image: item.item?.plateImage ?? '',
        rate: double.tryParse(item.item?.rate ?? '0') ?? 0.0,
        reviewCount: item.item?.rateCount ?? 0,

        outOfStock: false,
        categoryPlateId: -1,
        hasOptions: item.item?.hasOptions ?? false,
        store: item.item?.storeInfo?.toEntity(),
      );
    }
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
