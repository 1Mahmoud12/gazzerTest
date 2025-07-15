part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _SettingsPreferenceComponent extends StatelessWidget {
  const _SettingsPreferenceComponent(this.client);
  final ClientEntity? client;
  @override
  Widget build(BuildContext context) {
    final startPadding = 32.0;
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${L10n.tr().settings} & ${L10n.tr().preferences}",
          style: TStyle.primaryBold(16),
        ),
        Divider(height: 33, thickness: 1, color: Co.purple.withAlpha(90)),

        ///
        _ItitleWithSvg(
          svg: Assets.assetsSvgLanguage,
          title: L10n.tr().language,
        ),
        LanguageDropList(startPadding: startPadding),
        const VerticalSpacing(16),

        ///
        _ItitleWithSvg(
          svg: Assets.assetsSvgAppearance,
          title: L10n.tr().appearance,
        ),
        ThemeBtn(startPadding: startPadding),
        const VerticalSpacing(16),

        ///
        _ItitleWithSvg(
          svg: Assets.assetsSvgPrivacy,
          title: "${L10n.tr().privacy} & ${L10n.tr().security}",
        ),
        Row(
          children: [
            HorizontalSpacing(startPadding - 12),
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    L10n.tr().privacySettings,
                    style: TStyle.blackRegular(14),
                  ),
                ),
                if (client != null)
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      L10n.tr().changePassword,
                      style: TStyle.blackRegular(14),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const VerticalSpacing(16),

        ///
        MainBtn(
          onPressed: () {},
          bgColor: Co.secondary,
          radius: 16,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              Icon(client == null ? Icons.login_outlined : Icons.logout_outlined, size: 20, color: Co.purple),
              Expanded(
                child: Text(
                  client == null ? L10n.tr().login : L10n.tr().signOut,
                  style: TStyle.primaryBold(14, font: FFamily.inter),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItitleWithSvg extends StatelessWidget {
  const _ItitleWithSvg({required this.title, required this.svg});
  final String title;
  final String svg;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        SvgPicture.asset(
          svg,
          height: 24,
          colorFilter: const ColorFilter.mode(Co.secondary, BlendMode.srcIn),
        ),
        Text(
          title,
          style: TStyle.primarySemi(16),
        ),
      ],
    );
  }
}
