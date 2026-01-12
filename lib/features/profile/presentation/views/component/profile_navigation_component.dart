part of '../profile_screen.dart';

class _ProfileNavigationComponent extends StatelessWidget {
  const _ProfileNavigationComponent({
    required this.iconColor,
    required this.textColor,
  });
  final Color? iconColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      textColor: textColor,
      arrowColor: iconColor,
      title: L10n.tr().loyaltyProgram,
      icon: Assets.loyaltyIc,
      body: Column(
        spacing: 12,
        children: [
          _NavigationItem(
            textColor: textColor,
            title: L10n.tr().loyaltyProgram,
            onTap: () {
              context.push(LoyaltyProgramHeroOneScreen.route);
            },
          ),
          _NavigationItem(
            textColor: textColor,
            title: L10n.tr().wallet,
            onTap: () {
              context.push(WalletScreen.route);
            },
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.title,
    required this.onTap,
    required this.textColor,
  });

  final String title;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.style14400.copyWith(color: textColor),
              ),
            ),
            RotatedBox(
              quarterTurns: L10n.isAr(context) ? 3 : 1,
              child: SvgPicture.asset(
                Assets.arrowUp,
                colorFilter: ColorFilter.mode(
                  context.isDarkMode ? Co.white : Co.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
