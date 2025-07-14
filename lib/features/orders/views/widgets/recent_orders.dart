part of '../orders_screen.dart';

class _RecentOrders extends StatelessWidget {
  const _RecentOrders();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L10n.tr().recentOrders, style: TStyle.primaryBold(20)),

        SizedBox(
          height: 220,
          child: ListView.separated(
            itemCount: 5,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final prod = Fakers.fakeProds[index];
              return SizedBox(
                width: 150,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Co.grey.withAlpha(15), borderRadius: AppConst.defaultBorderRadius),
                  child: Column(
                    spacing: 6,
                    children: [
                      Expanded(
                        flex: 5,
                        child: DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                            ),
                            border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 1.5),
                          ),

                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                            ),
                            child: Image.asset(
                              prod.image,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#00${index + 1}",
                                      style: TStyle.blackSemi(12),
                                    ),
                                    Text(
                                      Helpers.getProperPrice(prod.price),
                                      style: TStyle.blackBold(12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Text("${L10n.tr().deliveredOn} 01/01/2025", style: TStyle.greySemi(12)),
                              Text(prod.name, style: TStyle.greySemi(12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
