import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';
import 'package:gazzer/features/dailyOffers/domain/daily_offer_repo.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_states.dart';

class DailyOfferCubit extends Cubit<DailyOfferStates> {
  final DailyOfferRepo _repo;
  int _currentPage = 1;
  final int _perPage = 10;
  PaginationInfo? _pagination;
  String? _currentType;
  String? _currentSearch;
  List<ItemsWithOffer> _allItems = [];
  List<StoresWithOffer> _allStores = [];

  DailyOfferCubit(this._repo) : super(DailyOfferInitialState());

  Future<void> getAllOffers({String? search, String? type, bool loadMore = false}) async {
    // Reset pagination if type or search changed
    if (_currentType != type || _currentSearch != search) {
      _currentPage = 1;
      _allItems.clear();
      _allStores.clear();
      _currentType = type;
      _currentSearch = search;
    }

    if (loadMore) {
      if (_pagination == null || !_pagination!.hasNext) return;
      _currentPage++;
      emit(DailyOfferLoadingMoreState(DailyOfferDataModel(itemsWithOffers: _allItems, storesWithOffers: _allStores), _pagination));
    } else {
      emit(DailyOfferLoadingState());

      // Only use cache when there's no search query and first page
      if ((search == null || search.isEmpty) && _currentPage == 1) {
        final cached = await _repo.getCachedDailyOffer();
        final hasCachedData = cached != null && ((cached.itemsWithOffers.isNotEmpty) || (cached.storesWithOffers.isNotEmpty));

        if (hasCachedData) {
          _allItems = List.from(cached.itemsWithOffers);
          _allStores = List.from(cached.storesWithOffers);
          emit(DailyOfferSuccessState(cached, isFromCache: true));
        }
      }
    }

    // Fetch data (with or without search)
    final res = await _repo.getAllDailyOffer(search: search, type: type, page: _currentPage, perPage: _perPage);
    switch (res) {
      case final Ok<DailyOfferResponse> ok:
        _pagination = ok.value.pagination;
        if (loadMore) {
          _allItems.addAll(ok.value.data?.itemsWithOffers ?? []);
          _allStores.addAll(ok.value.data?.storesWithOffers ?? []);
        } else {
          _allItems = List.from(ok.value.data?.itemsWithOffers ?? []);
          _allStores = List.from(ok.value.data?.storesWithOffers ?? []);
        }
        emit(
          DailyOfferSuccessState(
            DailyOfferDataModel(itemsWithOffers: _allItems, storesWithOffers: _allStores),
            pagination: _pagination,
          ),
        );
        break;
      case final Err err:
        if (!loadMore) {
          emit(DailyOfferErrorState(err.error.message));
        }
        break;
    }
  }

  bool get hasMore => _pagination?.hasNext ?? false;

  @override
  void emit(DailyOfferStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
