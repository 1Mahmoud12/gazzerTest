part of '../grocery_screen.dart';

class _GroceryAddWidget extends StatelessWidget {
  const _GroceryAddWidget();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Stack(
        children: [
          SizedBox.expand(child: Image.asset(Assets.assetsPngGroceryAdd, fit: BoxFit.fill)),
          Align(
            alignment: const Alignment(-0.9, 0.7),
            child: MainBtn(
              onPressed: () {},
              bgColor: Co.secondary,
              text: "Shop now",
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              textStyle: TStyle.primaryBold(14),
            ),
          ),
        ],
      ),
    );
  }
}
