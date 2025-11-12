import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class AddFundWidget extends StatefulWidget {
  const AddFundWidget({super.key});

  @override
  State<AddFundWidget> createState() => _AddFundWidgetState();
}

class _AddFundWidgetState extends State<AddFundWidget> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().walletAddFunds,
          style: TStyle.robotBlackTitle(),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Co.bg,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Co.purple100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.visaIc),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      L10n.tr().walletRechargeViaCard,
                      style: TStyle.blackMedium(16, font: FFamily.roboto),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const VerticalSpacing(16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: MainTextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TStyle.blackMedium(16, font: FFamily.roboto),
                      hintText: L10n.tr().walletEnterAmount,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MainBtn(
                      onPressed: () {},
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      bgColor: Co.purple,
                      text: L10n.tr().walletRechargeNow,
                      textStyle: TStyle.whiteBold(16, font: FFamily.roboto),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
