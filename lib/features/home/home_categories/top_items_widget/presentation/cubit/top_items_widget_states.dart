import 'package:equatable/equatable.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

abstract class TopItemsWidgetState extends Equatable {
  const TopItemsWidgetState();

  @override
  List<Object?> get props => [];
}

class TopItemsWidgetInitialState extends TopItemsWidgetState {}

class TopItemsWidgetLoadingState extends TopItemsWidgetState {}

class TopItemsWidgetSuccessState extends TopItemsWidgetState {
  final List<GenericItemEntity> items;
  final BannerEntity? banner;

  const TopItemsWidgetSuccessState(this.items, this.banner);

  @override
  List<Object?> get props => [items, banner];
}

class TopItemsWidgetErrorState extends TopItemsWidgetState {
  final String message;

  const TopItemsWidgetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
