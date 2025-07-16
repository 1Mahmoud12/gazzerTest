part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _SettingsPreferenceComponent extends StatelessWidget {
  const _SettingsPreferenceComponent(this.client);
  final ClientEntity? client;
  @override
  Widget build(BuildContext context) {
    final startPadding = 32.0;
    return BlocListener<ProfileCubit, ProfileStates>(
      listenWhen: (previous, current) => current is LogoutSuccess || current is LogoutError,
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Alerts.showToast(state.message, error: false);
        } else if (state is LogoutError) {
          Alerts.showToast(state.message);
        }
      },
      child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () {
                        context.myPush(
                          BlocProvider.value(
                            value: context.read<ProfileCubit>(),
                            child: const UpodatePasswordScreen(),
                          ),
                        );
                      },
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
          if (client != null)
            BlocBuilder<ProfileCubit, ProfileStates>(
              buildWhen: (previous, current) => previous is LogoutLoading && current is LogoutLoading,
              builder: (context, state) => MainBtn(
                onPressed: () {
                  context.read<ProfileCubit>().logout();
                },
                isLoading: state is LogoutLoading,
                bgColor: Co.secondary,
                radius: 16,
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
            )
          else
            MainBtn(
              onPressed: () {
                AppNavigator().push(
                  BlocProvider(
                    create: (context) => di<LoginCubit>(),
                    child: const LoginScreen(),
                  ),
                  parent: Parent.main,
                );
              },
              bgColor: Co.secondary,
              radius: 16,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                spacing: 16,
                children: [
                  const Icon(Icons.login_outlined, size: 20, color: Co.purple),
                  Expanded(
                    child: Text(
                      L10n.tr().login,
                      style: TStyle.primaryBold(14, font: FFamily.inter),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
        ],
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
