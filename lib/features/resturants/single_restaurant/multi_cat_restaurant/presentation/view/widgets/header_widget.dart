part of '../multi_cat_restaurant_screen.dart';

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 185.0;

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SizedBox.expand(
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 1.5,
                widthFactor: 2.5,
                child: ClipPath(
                  clipper: AddShapeClipper(),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: Grad.bgLinear.copyWith(
                        colors: [Co.buttonGradient.withAlpha(200), Co.bg.withAlpha(0)],
                        stops: const [0.0, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                VendorCard(vendor),
                ClipOval(child: Image.asset(vendor.image, height: 125, width: 125, fit: BoxFit.cover)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
