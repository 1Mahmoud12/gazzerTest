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
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.myPush(const SearchScreen());
            },
            child: AbsorbPointer(
              absorbing: true,
              child: Hero(
                tag: Tags.searchBar,
                child: MainTextField(
                  controller: controller,
                  height: 80,
                  borderRadius: 64,
                  hintText: "Search for restaurants, items, or categories",
                  bgColor: Colors.transparent,
                  prefix: const Icon(Icons.search, color: Co.purple, size: 24),
                ),
              ),
            ),
          ),
        ),
        const HorizontalSpacing(64),
      ],
    );
  }
}
