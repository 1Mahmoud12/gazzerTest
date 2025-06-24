import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

abstract class Helpers {
  static Future customTryCatch(Future Function() func) async {
    try {
      await func();
    } catch (e, stack) {
      if (kDebugMode) print(e.toString());
      // TODO: send to crashlytics
    }
  }

  static String? formatDate(String? date, {bool showDate = true, bool showTime = false}) {
    if (date == null) return null;
    try {
      final parsed = DateTime.parse(date);
      final formateddate = DateFormat('MMM dd, yyyy').format(parsed);
      final formatedTime = DateFormat('jms').format(parsed);
      return showDate ? formateddate + (showTime ? ' $formatedTime' : '') : formatedTime;
    } catch (e) {
      return null;
    }
  }

  static String? countDownTime(int seconds) {
    try {
      final parsed = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      final formatedTime = DateFormat('hh:mm:ss').format(parsed);
      return formatedTime;
    } catch (e) {
      return null;
    }
  }

  // static Widget concatinateTheCurrency({required num? amount, TextStyle? style, Color? color}) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('EG', style: TStyle.primarySemi(10).copyWith(color: color)),
  //           Text(amount.toString().split('.').first, style: TStyle.primaryBold(18).copyWith(color: color)),
  //           Text(" ${amount?.toStringAsFixed(2).split('.').last}",
  //               style: TStyle.primarySemi(10).copyWith(color: color)),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  static String getProperPrice(num price, {bool showCurrency = true}) {
    final isInt = price % 1 == 0;
    return (showCurrency ? ('EGP ') : '') + (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(2));
  }

  // static Widget getProperPriceWidget(num price, {TextStyle? egStyle, TextStyle? style}) {
  //   final isInt = price % 1 == 0;
  //   // ('EG ') + (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(2));
  //   return Text.rich(TextSpan(children: [
  //     TextSpan(
  //       text: 'EG ',
  //       style: egStyle ?? TStyle.greySemi(13),
  //     ),
  //     TextSpan(
  //       text: (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(2)),
  //       style: style ?? TStyle.blackBold(13),
  //     ),
  //   ]));
  // }

  // static bool requestLogin(BuildContext context) {
  //   if (SessionData.inst.user == null) {
  //     showDialog<bool?>(
  //       context: context,
  //       builder: (context) => Dialogs.confirmDialog(title: L10n.tr().pleaseLoginFirst),
  //     ).then((c) {
  //       if (c == true && context.mounted) context.push(LoginScreen.routeName(false));
  //     });
  //     return true;
  //   }
  //   return false;
  // }
}
