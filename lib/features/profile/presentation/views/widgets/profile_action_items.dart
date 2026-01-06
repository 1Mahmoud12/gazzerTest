part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

/// Privacy & Security navigation item
class _PrivacySecurityItem extends StatelessWidget {
  const _PrivacySecurityItem();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to privacy settings screen or show dialog
        // For now, show a toast
        Alerts.showToast('Privacy & Security');
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          SvgPicture.asset(Assets.privacyIc, height: 24, width: 24, colorFilter: const ColorFilter.mode(Co.secondary, BlendMode.srcIn)),
          const HorizontalSpacing(16),
          Expanded(
            child: Text('${L10n.tr().privacy} & ${L10n.tr().security}', style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
          ),
          RotatedBox(
            quarterTurns: L10n.isAr(context) ? 3 : 1,
            child: SvgPicture.asset(Assets.arrowUp, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }
}

/// Get Support navigation item
class _GetSupportItem extends StatelessWidget {
  const _GetSupportItem();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/support-screen');
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          SvgPicture.asset(Assets.getSupportIc, height: 24, width: 24, colorFilter: const ColorFilter.mode(Co.secondary, BlendMode.srcIn)),
          const HorizontalSpacing(16),
          Expanded(
            child: Text(L10n.tr().getSupport, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
          ),
          RotatedBox(
            quarterTurns: L10n.isAr(context) ? 3 : 1,
            child: SvgPicture.asset(Assets.arrowUp, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }
}

/// Sign Out button
class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.cubit});

  final ProfileCubit cubit;

  Future<void> _showSignOutConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon at the top
              SvgPicture.asset(Assets.signOutIc, colorFilter: const ColorFilter.mode(Co.logoutRed, BlendMode.srcIn)),
              const VerticalSpacing(24),
              // Confirmation text
              Text(L10n.tr().areYouSureYouWantToLogout, style: TStyle.robotBlackMedium().copyWith(fontSize: 16), textAlign: TextAlign.center),
              const VerticalSpacing(32),
              // Sign Out button
              MainBtn(
                onPressed: () {
                  context.pop(true);
                  context.go(HomeScreen.route);
                },
                bgColor: Co.purple,
                radius: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      L10n.tr().signOut,
                      style: TStyle.robotBlackRegular14().copyWith(color: Co.white, fontWeight: TStyle.medium),
                    ),
                    const HorizontalSpacing(8),
                    SvgPicture.asset(Assets.signOutIc, height: 20, width: 20, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && context.mounted) {
      cubit.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      buildWhen: (previous, current) => previous is LogoutLoading && current is LogoutLoading,
      builder: (context, state) => MainBtn(
        onPressed: () {
          _showSignOutConfirmation(context);
        },
        isLoading: state is LogoutLoading,
        bgColor: Co.purple,
        radius: 16,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: L10n.isAr(context) ? 0 : 2,
              child: SvgPicture.asset(Assets.signOutIc, height: 20, width: 20, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            ),
            const HorizontalSpacing(8),
            Text(
              L10n.tr().signOut,
              style: TStyle.robotBlackRegular14().copyWith(color: Co.white, fontWeight: TStyle.medium),
            ),
          ],
        ),
      ),
    );
  }
}

/// Delete Account item
class _DeleteAccountItem extends StatelessWidget {
  const _DeleteAccountItem({required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DeleteAccountRoute($extra: cubit).push(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.deleteIc, height: 24, width: 24, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn)),
            const HorizontalSpacing(16),
            Text(L10n.tr().deleteAccount, style: TStyle.robotBlackMedium().copyWith(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
