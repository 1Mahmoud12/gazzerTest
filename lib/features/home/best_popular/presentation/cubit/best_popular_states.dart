import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class BestPopularStates {
  final List<StoreEntity> stores;

  BestPopularStates({this.stores = const []});
}

class BestPopularLoadingState extends BestPopularStates {
  BestPopularLoadingState() : super();
}

class BestPopularLoadingMoreState extends BestPopularStates {
  final PaginationInfo? pagination;

  BestPopularLoadingMoreState({required List<StoreEntity> stores, this.pagination}) : super(stores: stores);
}

class BestPopularSuccessState extends BestPopularStates {
  final PaginationInfo? pagination;

  BestPopularSuccessState({required List<StoreEntity> stores, this.pagination}) : super(stores: stores);
}

class BestPopularErrorState extends BestPopularStates {
  final String error;

  BestPopularErrorState({required this.error});
}
