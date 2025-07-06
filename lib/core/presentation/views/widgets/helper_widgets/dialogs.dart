// import 'package:flutter/material.dart';

// class Dialogs {
//   static Dialog confirmDialog({
//     required String title,
//     String? message,
//     String? okBtn,
//     Color? okColor,
//     Color? okBgColor,
//     String? cancelBtn,
//     Color? cancelColor,
//     Color? cancelBgColor,
//   }) {
//     return Dialog(
//       child: Container(
//         decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const VerticalSpacing(20),
//               Text(
//                 title,
//                 style: TStyle.darkBold(18),
//                 textAlign: TextAlign.center,
//               ),
//               const VerticalSpacing(10),
//               if (message != null)
//                 Text(
//                   message,
//                   style: TStyle.darkRegular(16),
//                   textAlign: TextAlign.center,
//                 ),
//               // const VericalSpacing(20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: MainButton(
//                         text: cancelBtn ?? L10n.tr().cancel,
//                         bgColor: cancelBgColor ?? Co.dark,
//                         style: cancelColor == null ? null : TStyle.whiteSemi(16).copyWith(color: cancelColor),
//                         ontap: () {
//                           AppConsts.navigatorKey.currentState!.context.pop(false);
//                         },
//                       ),
//                     ),
//                     const HorizontalSpacing(20),
//                     Expanded(
//                       child: MainButton(
//                         text: okBtn ?? L10n.tr().confirm,
//                         bgColor: okBgColor ?? Co.primary,
//                         style: okColor == null ? null : TStyle.whiteSemi(16).copyWith(color: okColor),
//                         ontap: () {
//                           AppConsts.navigatorKey.currentState!.context.pop(true);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static Future<(bool, String)?> confirmWzTextField({
//     required String title,
//     required BuildContext context,
//     String? label,
//     String? okBtn,
//     Color? okColor,
//     Color? okBgColor,
//     String? cancelBtn,
//     Color? cancelColor,
//     Color? cancelBgColor,
//   }) async {
//     String reason = '';

//     return await showDialog<(bool, String)?>(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Co.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const VerticalSpacing(20),
//               Text(
//                 title,
//                 style: TStyle.darkBold(16),
//               ),
//               const VerticalSpacing(10),
//               MainTextField(
//                 controller: TextEditingController(),
//                 label: label,
//                 showBorder: true,
//                 onChange: (p0) => reason = p0,
//                 validator: Validators.notEmpty,
//                 borderColor: Co.black,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: MainButton(
//                         text: cancelBtn ?? L10n.tr().cancel,
//                         bgColor: cancelBgColor ?? Co.greyishBlack,
//                         style: cancelColor == null ? null : TStyle.whiteSemi(16).copyWith(color: cancelColor),
//                         ontap: () {
//                           AppConsts.navigatorKey.currentState!.context.myPop(result: (false, ''));
//                         },
//                       ),
//                     ),
//                     const HorizontalSpacing(20),
//                     Expanded(
//                       child: MainButton(
//                         text: okBtn ?? L10n.tr().confirm,
//                         bgColor: okBgColor ?? Co.primary,
//                         style: okColor == null ? null : TStyle.whiteSemi(16).copyWith(color: okColor),
//                         ontap: () {
//                           if (reason.isEmpty) {
//                             Alerts.showToast(L10n.tr().thisFieldIsRequired);
//                             return;
//                           }
//                           AppConsts.navigatorKey.currentState!.context.myPop(result: (true, reason));
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // static mainErrorDialog(ErrorModel errorModel) {
//   //   return Dialog(
//   //     child: Padding(
//   //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           Icon(CupertinoIcons.clear_circled_solid, color: Co.red, size: 35),
//   //           const VericalSpacing(20),
//   //           ListView.separated(
//   //             shrinkWrap: true,
//   //             itemCount: (errorModel.errors ?? []).length,
//   //             separatorBuilder: (context, index) => Padding(
//   //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//   //               child: const Divider(),
//   //             ),
//   //             itemBuilder: (context, index) {
//   //               return Row(
//   //                 children: [
//   //                   Icon(CupertinoIcons.circle_fill,
//   //                       color: Co.lightGrey, size: 13),
//   //                   const WidthSpacing(10),
//   //                   Expanded(
//   //                       child: Text((errorModel.errors!)[index],
//   //                           style: TStyle.blackSemi(14))),
//   //                 ],
//   //               );
//   //             },
//   //           ),
//   //           const VericalSpacing(20),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   static infoDialog({required String title, String? message, String? okBtn, Color? okColor, Color? okBgColor}) {
//     return Dialog(
//       child: Container(
//         decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const VerticalSpacing(20),
//               Text(title, style: TStyle.darkBold(18)),
//               const VerticalSpacing(10),
//               if (message != null) Text(message, style: TStyle.darkRegular(16)),
//               // const VericalSpacing(20),
//               // Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               //   child: MainButton(
//               //     text: okBtn ?? L10n.tr().confirm,
//               //     bgColor: okBgColor ?? Co.primary,
//               //     style: okColor == null
//               //         ? null
//               //         : TStyle.whiteSemi(16).copyWith(color: okColor),
//               //     ontap: () {
//               //       AppConsts.navigatorKey.currentState!.context
//               //           .myPop(result: true);
//               //     },
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
