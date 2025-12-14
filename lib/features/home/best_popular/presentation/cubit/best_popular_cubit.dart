import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/best_popular/data/dtos/best_popular_response_dto.dart';
import 'package:gazzer/features/home/best_popular/data/repositories/best_popular_repository_impl.dart';
import 'package:gazzer/features/home/best_popular/domain/repositories/best_popular_repository.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularCubit extends Cubit<BestPopularStates> {
  final BestPopularRepository _repository;
  int _currentPage = 1;
  final int _perPage = 10;
  PaginationInfo? _pagination;
  List<StoreEntity> _allStores = [];

  BestPopularCubit({required BestPopularRepository repository}) : _repository = repository, super(BestPopularLoadingState());

  static Future<BestPopularCubit> create() async {
    return BestPopularCubit(repository: BestPopularRepositoryImpl(ApiClient(), CrashlyticsRepoImp()));
  }

  Future<void> getBestPopularStores({bool loadMore = false}) async {
    if (loadMore) {
      if (_pagination == null || !_pagination!.hasNext) return;
      _currentPage++;
      emit(BestPopularLoadingMoreState(stores: _allStores, pagination: _pagination));
    } else {
      emit(BestPopularLoadingState());
      _currentPage = 1;
      _allStores.clear();

      // Check cache first
      final cached = await _repository.getCachedBestPopularStores();
      final hasCachedData = cached != null && cached.isNotEmpty;

      if (hasCachedData) {
        _allStores = List.from(cached);
        emit(BestPopularSuccessState(stores: _allStores));
      }
    }

    // Fetch data from API
    final result = await _repository.getBestPopularStores(page: _currentPage, perPage: _perPage);

    switch (result) {
      case Ok<BestPopularResponse> ok:
        if (loadMore) {
          _allStores.addAll(ok.value.stores);
        } else {
          _allStores = List.from(ok.value.stores);
        }
        _pagination = ok.value.pagination;
        emit(BestPopularSuccessState(stores: _allStores, pagination: _pagination));
        break;
      case Err<BestPopularResponse> err:
        if (!loadMore) {
          emit(BestPopularErrorState(error: err.error.message));
        }
        break;
    }
  }

  bool get hasMore => _pagination?.hasNext ?? false;
}
