part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _SettingsPreferenceComponent extends StatelessWidget {
  const _SettingsPreferenceComponent(this.client);
  final ClientEntity? client;
  @override
  Widget build(BuildContext context) {
    const startPadding = 32.0;
    return BlocListener<ProfileCubit, ProfileStates>(
      listenWhen: (previous, current) => current is LogoutSuccess || current is LogoutError,
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Alerts.showToast(state.message, error: false);
        } else if (state is LogoutError) {
          Alerts.showToast(state.message);
        }
      },
      child: ExpandableWidget(
        initiallyExpanded: true,
        icon: Assets.settingIc,
        title: '${L10n.tr().settings} & ${L10n.tr().preferences}',
        titleStyle: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
        body: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            Row(
              children: [
                _ItitleWithSvg(svg: Assets.languageIc, title: L10n.tr().language),
                const SizedBox(width: 20),
                const Expanded(child: LanguageCustomDropdown(startPadding: 0)),
              ],
            ),
            const VerticalSpacing(6),

            ///
            Row(
              children: [
                _ItitleWithSvg(svg: Assets.appearanceIc, title: L10n.tr().appearance),
                const SizedBox(width: 20),
                const Spacer(),
                const ThemeBtn(startPadding: startPadding),
              ],
            ),
            const VerticalSpacing(6),
            const _PrivacySecurityItem(),
            const VerticalSpacing(12),
            const _GetSupportItem(),
            const VerticalSpacing(12),

            ///
            // _ItitleWithSvg(svg: Assets.assetsSvgPrivacy, title: '${L10n.tr().privacy} & ${L10n.tr().security}'),
            // Row(
            //   children: [
            //     const HorizontalSpacing(startPadding - 12),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         TextButton(
            //           onPressed: () {},
            //           style: TextButton.styleFrom(
            //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //             minimumSize: Size.zero,
            //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //           ),
            //           child: Text(L10n.tr().privacySettings, style: context.style16400),
            //         ),
            //         if (client != null)
            //           TextButton(
            //             onPressed: () {
            //               final cubit = context.read<ProfileCubit>();
            //               UpodatePasswordRoute($extra: cubit).push(context);
            //             },
            //             style: TextButton.styleFrom(
            //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //               minimumSize: Size.zero,
            //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //             ),
            //             child: Text(L10n.tr().changePassword, style: context.style16400),
            //           ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
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
        SvgPicture.asset(svg, height: 24, colorFilter: const ColorFilter.mode(Co.secondary, BlendMode.srcIn)),
        Text(title, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
      ],
    );
  }
}
