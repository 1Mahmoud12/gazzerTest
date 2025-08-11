part of "../home_screen.dart";

class _HomeSearchWidget extends StatelessWidget {
  const _HomeSearchWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const HorizontalSpacing(6),

        Expanded(
          child: MainSearchWidget(
            height: 80,
            borderRadius: 64,
            hintText: L10n.tr().searchForStoresItemsAndCAtegories,
            bgColor: Colors.transparent,
            prefix: const Icon(Icons.search, color: Co.purple, size: 24),
          ),
        ),
        HorizontalSpacing(AppConst.floatingCartWidth),
      ],
    );
  }
}
