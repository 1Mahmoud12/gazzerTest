import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/confirm_sheet.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
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
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppConst.defaultBorderRadius,
          border: const GradientBoxBorder(
            gradient: LinearGradient(
              colors: [Co.purple, Co.bg],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.1],
            ),
          ),
        ),
        child: Padding(
          padding: AppConst.defaultHrPadding,
          child: StreamBuilder(
            stream: bus.getStream<AddressCardEvents>(),
            builder: (context, snapshot) {
              if (snapshot.data?.id == address.id && snapshot.data is AddressCardErrors) {
                Alerts.showToast((snapshot.data as AddressCardErrors).error);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Co.secondary,
                        child: SvgPicture.asset(
                          address.labelSvg,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                        ),
                      ),
                      const HorizontalSpacing(20),

                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              spacing: 12,
                              children: [
                                Flexible(
                                  child: Text(
                                    address.labelType.label ?? address.label,
                                    style: TStyle.primarySemi(16),
                                    maxLines: 2,
                                  ),
                                ),
                                if (address.isDefault)
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: AppConst.defaultInnerBorderRadius,
                                      color: Co.purple,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Text(
                                        L10n.tr().defaultt,
                                        style: TStyle.secondarySemi(14),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: address.provinceName),
                                  TextSpan(text: ", ${address.zoneName}"),
                                  TextSpan(text: ", ${L10n.tr().building} ${address.building}"),
                                  TextSpan(text: ", ${L10n.tr().floor} ${address.floor}"),
                                  TextSpan(text: ", ${L10n.tr().apartmentNumber} ${address.apartment}"),
                                  if (address.landmark != null)
                                    TextSpan(text: ", ${L10n.tr().landmark} ${address.landmark}."),
                                ],
                                style: TStyle.greyRegular(12).copyWith(height: 1.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        spacing: 4,
                        children: [
                          IconButton(
                            onPressed: () {
                              AddEditAddressRoute($extra: address).push(context);
                            },
                            style: IconButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: const Icon(Icons.edit, color: Co.purple),
                          ),
                          if (!address.isDefault)
                            IconButton(
                              onPressed: snapshot.data is DeleteAddressLoading
                                  ? null
                                  : () async {
                                      final res = await showModalBottomSheet<bool>(
                                        context: context,
                                        useSafeArea: true,
                                        constraints: const BoxConstraints(minHeight: 250),
                                        builder: (context) => ConfirmSheet(
                                          msg: L10n.tr().confirmDeleteAddressName(
                                            AddressLabel.fromString(address.label).label ?? address.label,
                                          ),
                                          btnText: L10n.tr().confirm,
                                        ),
                                      );
                                      if (res == true) bus.deleteAddress(address.id);
                                    },
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(5),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: snapshot.data is DeleteAddressLoading && snapshot.data?.id == address.id
                                  ? const AdaptiveProgressIndicator(size: 16)
                                  : const Icon(CupertinoIcons.delete, color: Co.purple),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (!address.isDefault)
                    TextButton(
                      onPressed: snapshot.data is SetDefaultLoading ? null : () => bus.setDefault(address.id),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                        minimumSize: Size.zero,
                      ),
                      child: snapshot.data is SetDefaultLoading && (snapshot.data as SetDefaultLoading).id == address.id
                          ? const AdaptiveProgressIndicator(size: 12)
                          : Text(
                              L10n.tr().setAsDefault,
                              style: TStyle.secondarySemi(14),
                            ),
                    )
                  else
                    const VerticalSpacing(12),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
