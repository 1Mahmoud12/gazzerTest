import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';
import 'package:gazzer/features/home/home_categories/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/cubit/suggests_cubit.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/cubit/suggests_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({super.key});

  static const route = '/suggested-screen';

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  String _searchQuery = '';
  List<SuggestEntity> _allItems = [];
  List<SuggestEntity> _filteredItems = [];

  // void _onSearchChanged(String value) {
  //   if (!context.mounted) return;
  //
  //   setState(() {
  //     _searchQuery = value;
  //     if (value.isEmpty) {
  //       _filteredItems = _allItems;
  //     } else {
  //       _filteredItems = _allItems.where((item) {
  //         final itemData = item.item;
  //         if (itemData == null) return false;
  //
  //         // Search in both plate and store_item fields
  //         final plateName = itemData.plateName?.toLowerCase() ?? '';
  //         final name = itemData.name?.toLowerCase() ?? '';
  //         final plateDescription =
  //             itemData.plateDescription?.toLowerCase() ?? '';
  //         final searchLower = value.toLowerCase();
  //
  //         return plateName.contains(searchLower) ||
  //             name.contains(searchLower) ||
  //             plateDescription.contains(searchLower);
  //       }).toList();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuggestsCubit(di.get<SuggestsRepo>())..getSuggests(),
      child: Scaffold(
        appBar: MainAppBar(
          title: L10n.tr().suggestedForYou,
          titleStyle: TStyle.robotBlackTitle().copyWith(color: Co.purple),
        ),
        //extendBody: true,
        //extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HomeCategoriesHeader(onChange: _onSearchChanged),
            Expanded(
              child: BlocBuilder<SuggestsCubit, SuggestsStates>(
                builder: (context, state) {
                  if (state is SuggestsLoadingState) {
                    return const Center(child: AdaptiveProgressIndicator());
                  }

                  if (state is SuggestsErrorState) {
                    return FailureComponent(
                      message: state.message,
                      onRetry: () {
                        context.read<SuggestsCubit>().getSuggests();
                      },
                    );
                  }

                  if (state is SuggestsSuccessState) {
                    // Store all items for local filtering
                    if (_allItems.isEmpty) {
                      _allItems = state.data?.entities ?? [];
                      _filteredItems = _allItems;
                    }
                    return _buildContent(context, _filteredItems, state.isFromCache);
                  }

                  return FailureComponent(
                    message: L10n.tr().noPersonalizedSuggestions,
                    onRetry: () {
                      context.read<SuggestsCubit>().getSuggests();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<SuggestEntity> items, bool isFromCache) {
    if (items.isEmpty) {
      return FailureComponent(message: _searchQuery.isEmpty ? L10n.tr().noPersonalizedSuggestions : L10n.tr().noSearchResults);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              items.length,
              (index) => items[index].id == null
                  ? const SizedBox.shrink()
                  : HorizontalProductCard(product: _convertToProductEntity(items[index]), width: MediaQuery.sizeOf(context).width * .48),
            ),
          ),
        ),
      ],
    );
  }

  // Convert SuggestEntity to ProductEntity for VerticalRotatedImgCard
  ProductEntity _convertToProductEntity(SuggestEntity item) {
    final SuggestEntity itemData = item;

    return ProductEntity(
      id: itemData.item?.id ?? 0,
      name: itemData.item?.name ?? itemData.item?.name ?? '',
      description: itemData.item?.plateDescription ?? '',
      price: double.tryParse(itemData.item?.price ?? '0') ?? 0.0,
      image: itemData.item?.plateImage ?? itemData.item?.image ?? '',
      rate: double.tryParse(itemData.item?.rate ?? '0') ?? 0.0,
      reviewCount: itemData.item?.rateCount ?? 0,
      outOfStock: false,
      store: itemData.item?.storeInfo?.toEntity(),
    );
  }
}
