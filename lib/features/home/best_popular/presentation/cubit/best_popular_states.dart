import 'package:gazzer/core/domain/vendor_entity.dart';

sealed class BestPopularStates {
  final List<VendorEntity> stores;

  BestPopularStates({this.stores = const []});
}

class BestPopularLoadingState extends BestPopularStates {
  BestPopularLoadingState() : super();
}

class BestPopularSuccessState extends BestPopularStates {
  BestPopularSuccessState({required List<VendorEntity> stores}) : super(stores: stores);
}

class BestPopularErrorState extends BestPopularStates {
  final String error;

  BestPopularErrorState({required this.error});
}
