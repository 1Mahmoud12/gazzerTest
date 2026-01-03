import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/data/dtos/suggests_dto.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/presentation/cubit/suggests_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/presentation/cubit/suggests_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({super.key});

  static const route = '/suggested-screen';

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  final ScrollController _scrollController = ScrollController();
  final String _searchQuery = '';
  List<SuggestEntity> _allItems = [];
  List<SuggestEntity> _filteredItems = [];
  SuggestsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = _cubit;
      if (cubit != null) {
        final currentState = cubit.state;
        if (cubit.hasMore && currentState is! SuggestsLoadingMoreState) {
          cubit.getSuggests(loadMore: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SuggestsCubit(di.get<SuggestsRepo>())..getSuggests();
        _cubit = cubit;
        return cubit;
      },
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
                    _allItems = state.data?.entities ?? [];
                    _filteredItems = _allItems;
                    return _buildContent(context, _filteredItems, state.isFromCache, state.pagination);
                  }

                  if (state is SuggestsLoadingMoreState) {
                    // Show existing items while loading more
                    _allItems = state.data?.entities ?? [];
                    _filteredItems = _allItems;
                    return _buildContent(context, _filteredItems, false, state.pagination, isLoadingMore: true);
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

  Widget _buildContent(BuildContext context, List<SuggestEntity> items, bool isFromCache, PaginationInfo? pagination, {bool isLoadingMore = false}) {
    if (items.isEmpty && !isLoadingMore) {
      return FailureComponent(message: _searchQuery.isEmpty ? L10n.tr().noPersonalizedSuggestions : L10n.tr().noSearchResults);
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Row(
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
                        : HorizontalProductCard(
                            product: _convertToGenericItemEntity(items[index]),
                            newUi: false,
                            width: MediaQuery.sizeOf(context).width * .45,
                          ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoadingMore) const AdaptiveProgressIndicator(),
          if (pagination != null && !pagination.hasNext && items.isNotEmpty) const Padding(padding: EdgeInsets.all(16.0), child: SizedBox.shrink()),
        ],
      ),
    );
  }

  // Convert SuggestEntity to GenericItemEntity (handles both products and plates)
  GenericItemEntity _convertToGenericItemEntity(SuggestEntity item) {
    final itemData = item.item;
    if (itemData == null) {
      // Fallback to empty ProductEntity if item is null
      return ProductEntity(id: item.id ?? 0, sold: 0, name: '', description: '', price: 0, image: '', rate: 0, reviewCount: 0, outOfStock: false);
    }

    final itemType = ItemType.fromString(item.itemType ?? '');
    final price = double.tryParse(itemData.appPrice ?? itemData.price ?? '0') ?? 0.0;
    final rate = double.tryParse(itemData.rate ?? '0') ?? 0.0;
    final reviewCount = itemData.rateCount ?? 0;
    final store = itemData.storeInfo?.toEntity() ?? item.storeInfo?.toEntity();

    // Convert offer if exists
    OfferEntity? offer;
    if (itemData.offer != null) {
      final suggestOffer = itemData.offer!;
      if (suggestOffer.discount != null && suggestOffer.discountType != null) {
        offer = OfferEntity(
          id: suggestOffer.id ?? 0,
          expiredAt: suggestOffer.expiredAt,
          discount: suggestOffer.discount!.toDouble(),
          discountType: DiscountType.fromString(suggestOffer.discountType ?? ''),
          maxDiscount: suggestOffer.maxDiscount ?? 0,
        );
      }
    }

    if (itemType == ItemType.plate) {
      // Convert to PlateEntity
      return PlateEntity(
        sold: 0,

        id: itemData.id ?? item.id ?? 0,
        name: itemData.plateName ?? itemData.name ?? '',
        description: itemData.plateDescription ?? '',
        image: itemData.plateImage ?? itemData.image ?? '',
        price: price,
        rate: rate,
        reviewCount: reviewCount,
        outOfStock: false,
        categoryPlateId: itemData.plateCategoryId ?? 0,
        hasOptions: itemData.hasOptions ?? false,
        offer: offer,
        store: store,
      );
    } else {
      // Convert to ProductEntity
      return ProductEntity(
        id: itemData.id ?? item.id ?? 0,
        name: itemData.name ?? '',
        sold: 0,

        description: itemData.plateDescription ?? '',
        price: price,
        image: itemData.image ?? itemData.plateImage ?? '',
        rate: rate,
        reviewCount: reviewCount,
        outOfStock: false,
        hasOptions: itemData.hasOptions ?? false,
        offer: offer,
        store: store,
        quantityInStock: itemData.quantityInStock,
      );
    }
  }
}
