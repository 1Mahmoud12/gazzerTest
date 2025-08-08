import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/cart/cart_item_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show GradientText;

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});
  static const route = '/order-confirm';
  @override
  Widget build(BuildContext context) {
    final btnText = [L10n.tr().addPRomoCode, L10n.tr().addDeliveryInstruction, L10n.tr().addTip];
    final cartITems = List.generate(
      5,
      (index) => CartItemModel.fromProduct(Fakers.plates[index % Fakers.plates.length]),
    );
    return Scaffold(
      appBar: AppBar(
        title: GradientText(text: L10n.tr().confirmOrder, style: TStyle.blackBold(18)),
      ),
      body: Center(
        child: Text(
          L10n.tr().noData,
          style: TStyle.primaryBold(16),
        ),
      ),

      //  ListView(
      //   padding: AppConst.defaultPadding,
      //   children: [
      //     Text(L10n.tr().orderSummary, style: TStyle.blackBold(16)),
      //     const VerticalSpacing(24),
      //     SizedBox(
      //       height: 250,
      //       child: ListView.separated(
      //         itemCount: 3,
      //         scrollDirection: Axis.horizontal,
      //         separatorBuilder: (context, index) => const HorizontalSpacing(12),
      //         itemBuilder: (context, index) {
      //           final cartProd = cartITems[index];
      //           return SizedBox(
      //             width: 180,
      //             child: DecoratedBox(
      //               position: DecorationPosition.foreground,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 border: Border.all(color: Colors.black26),
      //               ),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(12),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Expanded(
      //                       flex: 5,
      //                       child: Image.asset(cartProd.image, fit: BoxFit.cover, width: double.infinity),
      //                     ),
      //                     Expanded(
      //                       flex: 3,
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Text.rich(
      //                           TextSpan(
      //                             children: [
      //                               TextSpan(text: cartProd.name, style: TStyle.blackBold(14)),
      //                               const TextSpan(text: "\n"),
      //                               const TextSpan(text: "Qty:"),
      //                               TextSpan(text: "${cartProd.quantity}", style: TStyle.blackBold(13)),
      //                               const TextSpan(text: "\n"),
      //                               const TextSpan(text: "Price: "),
      //                               TextSpan(text: Helpers.getProperPrice(cartProd.price), style: TStyle.blackSemi(13)),
      //                             ],
      //                             style: TStyle.blackSemi(13),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //     const VerticalSpacing(24),

      //     ...List.generate(btnText.length, (index) {
      //       return Padding(
      //         padding: const EdgeInsetsGeometry.symmetric(vertical: 12),
      //         child: OptionBtn(
      //           onPressed: () {},
      //           radius: 16,
      //           text: btnText[index],
      //           textStyle: TStyle.primaryBold(14),
      //           height: 0,
      //           padding: const EdgeInsets.symmetric(vertical: 8),
      //         ),
      //       );
      //     }),
      //     const VerticalSpacing(32),
      //     OptionBtn(
      //       onPressed: () {
      //         context.push(PostCheckoutScreen.route);
      //       },
      //       height: 0,
      //       padding: const EdgeInsets.symmetric(vertical: 8),
      //       text: L10n.tr().confirmOrder,
      //       textStyle: TStyle.primaryBold(14),
      //     ),
      //   ],
      // ),
    );
  }
}
