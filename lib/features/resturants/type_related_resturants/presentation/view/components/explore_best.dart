part of '../type_related_restaurants_screen.dart';

class _ExploreBest extends StatelessWidget {
  const _ExploreBest();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(text: "Explore Best", style: TStyle.blackBold(24)),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          padding: AppConst.defaultHrPadding,
          separatorBuilder: (context, index) => const VerticalSpacing(16),
          itemBuilder: (context, index) {
            final prod = Fakers.fakeProds[index];
            return SizedBox(
              height: 140,
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: constraints.maxWidth - (constraints.maxHeight / 2),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: Grad.bglightLinear,
                            borderRadius: AppConst.defaultBorderRadius,
                          ),
                          child: Row(
                            children: [
                              const HorizontalSpacing(70),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GradientText(text: prod.name, style: TStyle.blackBold(20)),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                                              gradient: Grad.bgLinear.copyWith(
                                                stops: const [0.0, 1],
                                                colors: [const Color(0x55402788), Colors.transparent],
                                              ),
                                            ),
                                            child: const FavoriteWidget(size: 20),
                                          ),
                                        ],
                                      ),
                                      GradientTextWzShadow(
                                        text: Helpers.getProperPrice(prod.price),
                                        style: TStyle.blackSemi(16),
                                        shadow: AppDec.blackTextShadow.first,
                                      ),
                                      RatingWidget(prod.rate.toStringAsFixed(1), itemSize: 14)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: Grad.bglightLinear.copyWith(colors: [Color(0xffCFC8DA), Co.bg]),
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [Colors.black.withAlpha(0), Co.buttonGradient],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.5, 1],
                            ),
                            width: 2,
                          ),
                        ),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxHeight,
                          child: Column(
                            children: [
                              ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 1),
                                  ),
                                  child: Image.asset(
                                    prod.image,
                                    fit: BoxFit.cover,
                                    height: constraints.maxHeight * 0.8,
                                    width: constraints.maxHeight * 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
