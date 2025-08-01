part of "../home_screen.dart";

class _HomeSearchWidget extends StatefulWidget {
  const _HomeSearchWidget();

  @override
  State<_HomeSearchWidget> createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<_HomeSearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const HorizontalSpacing(6),

        Expanded(
          child: GestureDetector(
            onTap: () {
              context.push(SearchScreen.route);
            },
            child: AbsorbPointer(
              absorbing: true,
              child: Hero(
                tag: Tags.searchBar,
                child: MainTextField(
                  controller: controller,
                  height: 80,
                  borderRadius: 64,
                  hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                  bgColor: Colors.transparent,
                  prefix: const Icon(Icons.search, color: Co.purple, size: 24),
                ),
              ),
            ),
          ),
        ),
        HorizontalSpacing(AppConst.floatingCartWidth),
      ],
    );
  }
}
