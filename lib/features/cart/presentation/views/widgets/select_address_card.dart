import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/confirm_sheet.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class SelectAddressCard extends StatelessWidget {
  const SelectAddressCard({super.key, required this.address, required this.onSelect});
  final AddressEntity address;
  final Function(AddressEntity) onSelect;
  @override
  Widget build(BuildContext context) {
    final address = AddressModel.fromEntity(this.address);
    final bus = di<AddressesBus>();
    return InkWell(
      onTap: () {
        onSelect(address);
      },
      child: StreamBuilder(
        stream: bus.getStream<AddressCardEvents>(),
        builder: (context, snapshot) {
          if (snapshot.data?.id == address.id && snapshot.data is AddressCardErrors) {
            Alerts.showToast((snapshot.data! as AddressCardErrors).error);
          }
          return Container(
            decoration: BoxDecoration(color: Co.lightPurple, borderRadius: BorderRadius.circular(24)),
            padding: AppConst.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    VectorGraphicsWidget(address.labelSvg, width: 20, height: 20, colorFilter: const ColorFilter.mode(Co.black, BlendMode.srcIn)),
                    const HorizontalSpacing(8),
                    Expanded(child: Text(address.labelType.label ?? address.label, style: TStyle.robotBlackMedium(), maxLines: 2)),
                    if (address.isDefault)
                      InkWell(
                        onTap: snapshot.data is SetDefaultLoading ? null : () => bus.setDefault(address.id),

                        child: DecoratedBox(
                          decoration: BoxDecoration(borderRadius: AppConst.defaultInnerBorderRadius, color: Co.purple),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: snapshot.data is SetDefaultLoading && (snapshot.data! as SetDefaultLoading).id == address.id
                                ? const AdaptiveProgressIndicator(size: 12)
                                : Text(L10n.tr().defaultt, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
                          ),
                        ),
                      )
                    else
                      InkWell(
                        onTap: snapshot.data is SetDefaultLoading ? null : () => bus.setDefault(address.id),
                        child: Text(L10n.tr().setAsDefault, style: TStyle.robotBlackThin().copyWith(color: Co.purple)),
                      ),
                  ],
                ),
                const VerticalSpacing(12),
                Column(
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        Image.asset(Assets.photoAddressMapIc),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: address.provinceName),
                                          TextSpan(text: ', ${address.zoneName}'),
                                          // TextSpan(text: ', ${L10n.tr().building} ${address.building}'),
                                          // TextSpan(text: ', ${L10n.tr().floor} ${address.floor}'),
                                          TextSpan(text: ', ${L10n.tr().apartmentNumber} ${address.apartment}'),
                                          if (address.landmark != null) TextSpan(text: ', ${L10n.tr().landmark} ${address.landmark}.'),
                                        ],
                                        style: context.style16400.copyWith(height: 1.7),
                                      ),
                                    ),
                                    Text('0${Session().client?.phoneNumber}', style: context.style16400.copyWith(height: 1.7)),
                                    Text('${Session().client?.clientName}', style: context.style16400.copyWith(height: 1.7)),
                                  ],
                                ),
                              ),
                              if (!address.isDefault)
                                InkWell(
                                  onTap: snapshot.data is DeleteAddressLoading
                                      ? null
                                      : () async {
                                          final res = await showModalBottomSheet<bool>(
                                            context: context,
                                            useSafeArea: true,
                                            constraints: const BoxConstraints(minHeight: 250),
                                            builder: (context) => ConfirmSheet(
                                              msg: L10n.tr().confirmDeleteAddressName(AddressLabel.fromString(address.label).label ?? address.label),
                                              btnText: L10n.tr().confirm,
                                            ),
                                          );
                                          if (res == true) bus.deleteAddress(address.id);
                                        },
                                  child: snapshot.data is DeleteAddressLoading && snapshot.data?.id == address.id
                                      ? const AdaptiveProgressIndicator(size: 16)
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const VectorGraphicsWidget(Assets.deleteIc),
                                            const HorizontalSpacing(4),
                                            Text(L10n.tr().delete, style: TStyle.robotBlackMedium()),
                                          ],
                                        ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
