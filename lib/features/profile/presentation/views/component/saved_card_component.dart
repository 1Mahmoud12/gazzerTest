part of '../profile_screen.dart';

class _SavedCardComponent extends StatelessWidget {
  const _SavedCardComponent({required this.iconColor, this.textColor});
  final Color? iconColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(SavedCardsScreen.route);
      },
      child: IgnorePointer(
        child: ExpandableWidget(
          textColor: textColor,
          arrowColor: iconColor,
          title: L10n.tr().saved_cards,
          icon: Assets.savedCardsIc,
          body: const SizedBox(),
        ),
      ),
    );
  }
}
