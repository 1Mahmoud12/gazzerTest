part of '../profile_screen.dart';

class _ProfileNavigationComponent extends StatelessWidget {
  const _ProfileNavigationComponent();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      title: L10n.tr().loyaltyProgram,
      icon: Assets.loyaltyIc,
      body: Column(
        spacing: 12,
        children: [
          _NavigationItem(
            title: L10n.tr().loyaltyProgram,
            onTap: () {
              context.push(LoyaltyProgramHeroOneScreen.route);
            },
          ),
          _NavigationItem(
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
  const _NavigationItem({required this.title, required this.onTap});

  final String title;
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
            Expanded(child: Text(title, style: TStyle.robotBlackMedium())),
            RotatedBox(quarterTurns: L10n.isAr(context) ? 3 : 1, child: SvgPicture.asset(Assets.arrowUp)),
          ],
        ),
      ),
    );
  }
}
