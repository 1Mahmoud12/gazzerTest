part of '../home_screen.dart';

class _HomeContactUsWidget extends StatelessWidget {
  const _HomeContactUsWidget();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => FractionallySizedBox(
        widthFactor: 1.1,
        child: ClipPath(
          clipper: AddShapeClipper(),
          child: Container(
            height: 150,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Fakers.fakeProds[3].image), fit: BoxFit.cover, opacity: 0.7),
            ),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: Grad.hoverGradient, borderRadius: AppConst.defaultBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Text("Order Whenever You Are", style: TStyle.whiteBold(16)),
                      Text("Contact Us", style: TStyle.whiteBold(14).copyWith(color: Co.secondary)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
