part of '../grocery_screen.dart';

class _GroceryHeader extends StatefulWidget {
  const _GroceryHeader();

  @override
  State<_GroceryHeader> createState() => __GroceryHeaderState();
}

class __GroceryHeaderState extends State<_GroceryHeader> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Co.secondary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(24, 0, 24, 24),
        child: SafeArea(
          bottom: false,
          child: Column(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VerticalSpacing(kToolbarHeight),
              MainTextField(
                controller: controller,
                height: 80,
                borderRadius: 64,
                hintText: "Search for restaurants, items, or categories",
                bgColor: Colors.transparent,
                prefix: const Icon(Icons.search, color: Co.purple, size: 24),
              ),
              GradientText(text: "Grocery Stores", style: TStyle.blackBold(24)),
            ],
          ),
        ),
      ),
    );
  }
}
