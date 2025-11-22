import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/support_call.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class GazzerSupportScreen extends StatelessWidget {
  const GazzerSupportScreen({super.key});

  static const route = '/gazzer-support';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Scaffold(
      appBar: MainAppBar(
        title: l10n.gazzerSupport,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              l10n.contactUs,
              style: TStyle.robotBlackSubTitle(),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(16),
            Text(
              l10n.callSupport,
              style: TStyle.blackRegular(14),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Co.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Co.purple, size: 24),
                  const HorizontalSpacing(12),
                  Text(
                    AppConst.supportPhoneNumber,
                    style: TStyle.primaryBold(18),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(24),
            MainBtn(
              onPressed: () {
                SupportCallService.callSupport(context);
              },
              text: l10n.callSupport,
              width: double.infinity,
              icon: Icons.phone,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
