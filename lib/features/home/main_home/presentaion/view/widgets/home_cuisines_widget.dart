part of '../home_screen.dart';

class _HomeCuisinesWidget extends StatelessWidget {
  const _HomeCuisinesWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TitleWithMore(title: L10n.tr().exploreCuisines, onPressed: () {}),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final cuisne = Fakers.fakeCuisines[index];
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: GradientBoxBorder(gradient: Grad().shadowGrad()),
                  borderRadius: BorderRadius.circular(66),
                  gradient: Grad().bgLinear.copyWith(
                    stops: const [0.0, 1],
                    colors: [const Color(0x55402788), Colors.transparent],
                  ),
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    CircleGradientBorderedImage(image: cuisne.image),
                    Text("${cuisne.name} ${cuisne.name}", style: TStyle.blackBold(12), textAlign: TextAlign.center),
                    const HorizontalSpacing(8),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox.shrink(),
        SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: Fakers.fakeCuisines.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final cuisne = Fakers.fakeCuisines[index];
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Column(
                  spacing: 8,
                  children: [
                    Expanded(child: CircleGradientBorderedImage(image: cuisne.image)),
                    Text(
                      cuisne.name,
                      style: TStyle.blackBold(12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
