import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

sealed class PlateDetailsStates {
  final PlateEntity plate;
  final List<PlateOptionEntity> options;
  final List<OrderedWithEntity> orderedWith;

  const PlateDetailsStates({this.plate = Fakers.plate, this.options = const [], this.orderedWith = const []});
}

class PlateDetailsInitial extends PlateDetailsStates {}

class PlateDetailsLoading extends PlateDetailsStates {
  PlateDetailsLoading() : super(plate: Fakers.plate, options: Fakers.plateOptions, orderedWith: Fakers.plateOrderedWith);
}

class PlateDetailsLoaded extends PlateDetailsStates {
  const PlateDetailsLoaded({
    required super.plate,
    required super.options,
    required super.orderedWith,
  });
}

class PlateDetailsError extends PlateDetailsStates {
  final String message;
  const PlateDetailsError({required this.message});
}
