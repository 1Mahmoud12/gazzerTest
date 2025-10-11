part of '../home_screen.dart';

class _HomeTopVendorsWidget extends StatelessWidget {
  const _HomeTopVendorsWidget({required this.vendors});
  final List<VendorEntity?> vendors;
  @override
  Widget build(BuildContext context) {
    if (vendors.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            TitleWithMore(title: L10n.tr().topVendors, onPressed: () {}),
            const VerticalSpacing(12),
            SizedBox(
              height: 70,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: vendors.length > 6 ? 4 : vendors.length,
                separatorBuilder: (context, index) => const HorizontalSpacing(12),
                itemBuilder: (context, index) {
                  if (vendors[index] == null) return const SizedBox.shrink();
                  final vendor = vendors[index];
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
                        CircleGradientBorderedImage(image: vendor!.image),
                        Text(
                          vendor.name,
                          style: TStyle.blackBold(12),
                          textAlign: TextAlign.center,
                        ),
                        const HorizontalSpacing(8),
                      ],
                    ),
                  );
                },
              ),
            ),
            const VerticalSpacing(12),
            if (vendors.length > 6) ...[
              const SizedBox.shrink(),
              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (vendors.length - 4) > 6 ? 6 : (vendors.length - 4),
                  separatorBuilder: (context, index) => const HorizontalSpacing(12),
                  itemBuilder: (context, index) {
                    if (vendors[index + 4] == null) return const SizedBox.shrink();
                    final cuisne = vendors[index + 4];
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 110),
                      child: Column(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: CircleGradientBorderedImage(
                              image: cuisne!.image,
                            ),
                          ),
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

            // const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
