part of '../orders_screen.dart';

class _HistoryOrdersWidget extends StatelessWidget {
  const _HistoryOrdersWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("History Orders", style: TStyle.primaryBold(20)),
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            padding: AppConst.defaultPadding,
            separatorBuilder: (context, index) => Divider(color: Co.secondary, height: 25),
            itemBuilder: (context, index) {
              final prod = Fakers.fakeProds[index];
              return Row(
                spacing: 12,
                children: [
                  ClipOval(child: Image.asset(prod.image, height: 40, width: 40, fit: BoxFit.cover)),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Order #00${index + 1}", style: TStyle.blackSemi(14)),
                          const TextSpan(text: "\n"),
                          TextSpan(text: "Delivered on 01/01/20252", style: TStyle.greyRegular(12)),
                        ],
                      ),
                    ),
                  ),
                  Text(Helpers.getProperPrice(prod.price), style: TStyle.blackSemi(14)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
