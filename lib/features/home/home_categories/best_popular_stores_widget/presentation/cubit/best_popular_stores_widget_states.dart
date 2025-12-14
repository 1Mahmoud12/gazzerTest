import 'package:equatable/equatable.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

abstract class BestPopularStoresWidgetState extends Equatable {
  const BestPopularStoresWidgetState();

  @override
  List<Object?> get props => [];
}

class BestPopularStoresWidgetInitialState extends BestPopularStoresWidgetState {}

class BestPopularStoresWidgetLoadingState extends BestPopularStoresWidgetState {}

class BestPopularStoresWidgetSuccessState extends BestPopularStoresWidgetState {
  final List<GenericVendorEntity> stores;
  final BannerEntity? banner;

  const BestPopularStoresWidgetSuccessState(this.stores, this.banner);

  @override
  List<Object?> get props => [stores, banner];
}

class BestPopularStoresWidgetErrorState extends BestPopularStoresWidgetState {
  final String message;

  const BestPopularStoresWidgetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
