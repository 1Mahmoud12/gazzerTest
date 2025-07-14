part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _SettingsPreferenceComponent extends StatelessWidget {
  const _SettingsPreferenceComponent();

  @override
  Widget build(BuildContext context) {
    final startPadding = 32.0;
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${L10n.tr().settings} & ${L10n.tr().preferences}",
          style: TStyle.whiteBold(16),
        ),
        const Divider(height: 33, thickness: 1, color: Colors.white38),

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
                    style: TStyle.secondaryRegular(14),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    L10n.tr().changePassword,
                    style: TStyle.secondaryRegular(14),
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              const Icon(Icons.logout_outlined, size: 20, color: Co.purple),
              Expanded(
                child: Text(
                  L10n.tr().signOut,
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
          style: TStyle.whiteSemi(16),
        ),
      ],
    );
  }
}
