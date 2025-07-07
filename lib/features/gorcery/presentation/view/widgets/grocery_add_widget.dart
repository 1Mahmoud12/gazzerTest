part of '../grocery_screen.dart';

class _GroceryAddWidget extends StatefulWidget {
  const _GroceryAddWidget();

  @override
  State<_GroceryAddWidget> createState() => _GroceryAddWidgetState();
}

class _GroceryAddWidgetState extends State<_GroceryAddWidget> {
  late final Timer timer;
  final adds = [Assets.assetsPngGroceryAdd, Assets.assetsPngGroceryAdd2, Assets.assetsPngGroceryAdd3];
  int index = 0;
  _animate() async {
    if (index >= adds.length - 1) {
      setState(() => index = 0);
    } else {
      setState(() => index++);
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _animate();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Stack(
        children: [
          SizedBox.expand(
            child: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              duration: Durations.extralong3,
              child: Image.asset(key: ValueKey(index), adds[index], fit: BoxFit.fill),
            ),
          ),
          Align(
            alignment: const Alignment(-0.9, 0.7),
            child: MainBtn(
              onPressed: () {},
              bgColor: Co.secondary,
              text: L10n.tr().shopNow,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              textStyle: TStyle.primaryBold(14),
            ),
          ),
        ],
      ),
    );
  }
}
