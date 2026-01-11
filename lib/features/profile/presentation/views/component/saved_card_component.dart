part of '../profile_screen.dart';

class _SavedCardComponent extends StatelessWidget {
  const _SavedCardComponent({required this.iconColor});
final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(SavedCardsScreen.route);
      },
      child: IgnorePointer(
        child: ExpandableWidget(
          
          arrowColor: iconColor,
          title: L10n.tr().saved_cards, icon: Assets.savedCardsIc, body: const SizedBox()),
      ),
    );
  }
}
