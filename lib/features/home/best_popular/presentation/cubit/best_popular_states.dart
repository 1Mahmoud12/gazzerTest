import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class BestPopularStates {
  final List<StoreEntity> stores;

  BestPopularStates({this.stores = const []});
}

class BestPopularLoadingState extends BestPopularStates {
  BestPopularLoadingState() : super();
}

class BestPopularSuccessState extends BestPopularStates {
  BestPopularSuccessState({required List<StoreEntity> stores}) : super(stores: stores);
}

class BestPopularErrorState extends BestPopularStates {
  final String error;

  BestPopularErrorState({required this.error});
}
