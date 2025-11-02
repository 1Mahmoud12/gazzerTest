import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText;
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_widget.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});
  static const route = '/order-confirm';

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          text: L10n.tr().confirmOrder,
          style: TStyle.blackBold(18),
        ),
      ),
      body: ListView(
        padding: AppConst.defaultPadding,
        children: [
          const VoucherWidget(),
        ],
      ),
    );
  }
}
