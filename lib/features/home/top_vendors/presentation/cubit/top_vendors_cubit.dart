import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/top_vendors/data/dtos/top_vendors_dto.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_states.dart';

class TopVendorsCubit extends Cubit<TopVendorsStates> {
  final TopVendorsRepo _repo;
  int _currentPage = 1;
  final int _perPage = 10;
  PaginationInfo? _pagination;
  List<VendorEntity> _allVendors = [];

  TopVendorsCubit(this._repo) : super(TopVendorsInitialState());

  Future<void> getTopVendors({bool loadMore = false}) async {
    if (loadMore) {
      if (_pagination == null || !_pagination!.hasNext) return;
      _currentPage++;
      emit(TopVendorsLoadingMoreState(_allVendors, _pagination));
    } else {
      emit(TopVendorsLoadingState());
      _currentPage = 1;
      _allVendors.clear();

      // Check cache first
      final cached = await _repo.getCachedTopVendors();
      final hasCachedData = cached != null && cached.isNotEmpty;

      if (hasCachedData) {
        _allVendors = List.from(cached);
        emit(TopVendorsSuccessState(_allVendors));
      }
    }

    // Fetch data from API
    final res = await _repo.getTopVendors(
      page: _currentPage,
      perPage: _perPage,
    );
    switch (res) {
      case Ok<TopVendorsResponse> ok:
        if (loadMore) {
          _allVendors.addAll(ok.value.vendors);
        } else {
          _allVendors = List.from(ok.value.vendors);
        }
        _pagination = ok.value.pagination;
        emit(TopVendorsSuccessState(_allVendors, pagination: _pagination));
        break;
      case Err err:
        if (!loadMore) {
          emit(TopVendorsErrorState(err.error.message));
        }
        break;
    }
  }

  bool get hasMore => _pagination?.hasNext ?? false;

  @override
  void emit(TopVendorsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
