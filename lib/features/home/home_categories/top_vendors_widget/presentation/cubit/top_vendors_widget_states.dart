import 'package:equatable/equatable.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';

abstract class TopVendorsWidgetState extends Equatable {
  const TopVendorsWidgetState();

  @override
  List<Object?> get props => [];
}

class TopVendorsWidgetInitialState extends TopVendorsWidgetState {}

class TopVendorsWidgetLoadingState extends TopVendorsWidgetState {}

class TopVendorsWidgetSuccessState extends TopVendorsWidgetState {
  final List<VendorEntity> vendors;
  final BannerEntity? banner;

  const TopVendorsWidgetSuccessState(this.vendors, this.banner);

  @override
  List<Object?> get props => [vendors, banner];
}

class TopVendorsWidgetErrorState extends TopVendorsWidgetState {
  final String message;

  const TopVendorsWidgetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
