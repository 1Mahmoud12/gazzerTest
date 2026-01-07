import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:go_router/go_router.dart';

class Dialogs {
  static Dialog confirmDialog({
    required String title,
    required BuildContext context,
    String? message,
    String? okBtn,
    Color? okColor,
    Color? okBgColor,
    String? cancelBtn,
    Color? cancelColor,
    Color? cancelBgColor,
  }) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacing(20),
              Text(
                title,
                style: TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold),
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing(10),
              if (message != null) Text(message, style: TStyle.robotBlackMedium(), textAlign: TextAlign.center),
              // const VericalSpacing(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: MainBtn(
                        text: cancelBtn ?? L10n.tr().cancel,
                        bgColor: cancelBgColor ?? Co.greyText,
                        textStyle: cancelColor == null ? null : context.style14400.copyWith(color: cancelColor, fontWeight: TStyle.medium),
                        onPressed: () {
                          context.pop(false);
                        },
                      ),
                    ),
                    const HorizontalSpacing(20),
                    Expanded(
                      child: MainBtn(
                        text: okBtn ?? L10n.tr().confirm,
                        bgColor: okBgColor ?? Co.purple,
                        textStyle: okColor == null ? null : context.style14400.copyWith(color: okColor, fontWeight: TStyle.medium),
                        onPressed: () {
                          context.pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static Future<(bool, String)?> confirmWzTextField({
  //   required String title,
  //   required BuildContext context,
  //   String? label,
  //   String? okBtn,
  //   Color? okColor,
  //   Color? okBgColor,
  //   String? cancelBtn,
  //   Color? cancelColor,
  //   Color? cancelBgColor,
  // }) async {
  //   String reason = '';

  //   return await showDialog<(bool, String)?>(
  //     context: context,
  //     builder: (context) => Dialog(
  //       backgroundColor: Co.white,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const VerticalSpacing(20),
  //             Text(
  //               title,
  //               style: TStyle.darkBold(16),
  //             ),
  //             const VerticalSpacing(10),
  //             MainTextField(
  //               controller: TextEditingController(),
  //               label: label,
  //               showBorder: true,
  //               onChange: (p0) => reason = p0,
  //               validator: Validators.notEmpty,
  //               borderColor: Co.black,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: MainBtn(
  //                       text: cancelBtn ?? L10n.tr().cancel,
  //                       bgColor: cancelBgColor ?? Co.greyishBlack,
  //                       style: cancelColor == null ? null : TStyle.whiteSemi(16).copyWith(color: cancelColor),
  //                       onPressed: () {
  //                         AppConsts.navigatorKey.currentState!.context.myPop(result: (false, ''));
  //                       },
  //                     ),
  //                   ),
  //                   const HorizontalSpacing(20),
  //                   Expanded(
  //                     child: MainBtn(
  //                       text: okBtn ?? L10n.tr().confirm,
  //                       bgColor: okBgColor ?? Co.primary,
  //                       style: okColor == null ? null : TStyle.whiteSemi(16).copyWith(color: okColor),
  //                       onPressed: () {
  //                         if (reason.isEmpty) {
  //                           Alerts.showToast(L10n.tr().thisFieldIsRequired);
  //                           return;
  //                         }
  //                         AppConsts.navigatorKey.currentState!.context.myPop(result: (true, reason));
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // // static mainErrorDialog(ErrorModel errorModel) {
  // //   return Dialog(
  // //     child: Padding(
  // //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  // //       child: Column(
  // //         mainAxisSize: MainAxisSize.min,
  // //         children: [
  // //           Icon(CupertinoIcons.clear_circled_solid, color: Co.red, size: 35),
  // //           const VericalSpacing(20),
  // //           ListView.separated(
  // //             shrinkWrap: true,
  // //             itemCount: (errorModel.errors ?? []).length,
  // //             separatorBuilder: (context, index) => Padding(
  // //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
  // //               child: const Divider(),
  // //             ),
  // //             itemBuilder: (context, index) {
  // //               return Row(
  // //                 children: [
  // //                   Icon(CupertinoIcons.circle_fill,
  // //                       color: Co.lightGrey, size: 13),
  // //                   const WidthSpacing(10),
  // //                   Expanded(
  // //                       child: Text((errorModel.errors!)[index],
  // //                           style: context.style14400)),
  // //                 ],
  // //               );
  // //             },
  // //           ),
  // //           const VericalSpacing(20),
  // //         ],
  // //       ),
  // //     ),
  // //   );
  // // }

  static infoDialog({required Function() onConfirm, required String title, String? message, String? okBtn, Color? okColor, Color? okBgColor}) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacing(20),
              Text(title, style: TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold)),
              const VerticalSpacing(10),
              if (message != null) Text(message, style: TStyle.robotBlackMedium()),
              const VerticalSpacing(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: MainBtn(
                  text: okBtn ?? L10n.tr().confirm,
                  bgColor: okBgColor ?? Co.purple,
                  textStyle: okColor == null
                      ? null
                      : AppNavigator.mainKey.currentContext!.style14400.copyWith(color: okColor, fontWeight: TStyle.medium),
                  onPressed: onConfirm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
