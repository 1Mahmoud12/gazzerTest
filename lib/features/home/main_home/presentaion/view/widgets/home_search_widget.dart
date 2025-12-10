part of '../home_screen.dart';

class _HomeSearchWidget extends StatelessWidget {
  const _HomeSearchWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MainSearchWidget(
        height: 80,
        hintText: L10n.tr().searchForStoresItemsAndCAtegories,
        bgColor: Colors.transparent,
        prefix: const Icon(Icons.search, color: Co.purple, size: 24),
      ),
    );
  }
}
