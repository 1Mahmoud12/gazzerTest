import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';

enum AddressLabel {
  home,
  work,
  other;

  String? get label {
    switch (this) {
      case AddressLabel.home:
        return L10n.tr().homeAddress;
      case AddressLabel.work:
        return L10n.tr().work;
      case AddressLabel.other:
        return null;
    }
  }

  factory AddressLabel.fromString(String? label) {
    switch (label) {
      case 'home':
        return AddressLabel.home;
      case 'work':
        return AddressLabel.work;
      default:
        return AddressLabel.other;
    }
  }
}

class AddressModel extends AddressEntity {
  final AddressLabel labelType;
  late final String labelSvg;

  /// The [label] of [labelType] will hold the translated label in case of home and work
  /// and null for other.
  ///
  /// In other cases, the [label] will be used as is.

  AddressModel.fromEntity(AddressEntity entity)
    : labelType = AddressLabel.fromString(entity.label),
      super(
        id: entity.id,
        provinceId: entity.provinceId,
        zoneId: entity.zoneId,
        label: entity.label,
        lat: entity.lat,
        lng: entity.lng,
        isDefault: entity.isDefault,
        floor: entity.floor,
        apartment: entity.apartment,
        building: entity.building,
        landmark: entity.landmark,
        provinceName: entity.provinceName,
        zoneName: entity.zoneName,
      ) {
    labelSvg = labelType.label == null
        ? Assets.assetsSvgLocation
        : labelType == AddressLabel.home
        ? Assets.assetsSvgHomeOutlined
        : Assets.assetsSvgWork;
  }
}
