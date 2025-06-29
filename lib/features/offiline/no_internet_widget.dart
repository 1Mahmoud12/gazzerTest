// import 'package:flutter/material.dart';
// import 'package:kure/config/app_consts.dart';
// import 'package:kure/config/localization/l10n/l10n.dart';
// import 'package:kure/config/theming/theming.dart';
// import 'package:kure/core/presentation/helpers/spacing.dart';
// import 'package:kure/features/general_widgets/main_button.dart';
// import 'package:kure/features/general_widgets/offiline/connection_bus.dart';

// class NoInternetWidget extends StatelessWidget {
//   const NoInternetWidget({super.key, required this.isLoading});
//   final bool isLoading;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, contrains) {
//       return SizedBox(
//           height: MediaQuery.sizeOf(context).height,
//           width: MediaQuery.sizeOf(context).width,
//           child: ColoredBox(
//             color: Colors.black38,
//             child: Center(
//               child: Dialog(
//                 elevation: 10,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Badge(
//                         label: Text(
//                           'Offline',
//                           style: TStyle.whiteBold(15),
//                         ),
//                         alignment: Alignment.centerRight,
//                         backgroundColor: Co.greyishBlack,
//                         child: const Icon(Icons.wifi_off_rounded, color: Co.grey, size: 65),
//                       ),
//                       const VerticalSpacing(16),
//                       // Text(L10n.tr().noInternetConnect, style: TStyle.blackBold(17)),
//                       const VerticalSpacing(8),
//                       Text(L10n.tr().pleaseCheckYourInternetConnection, style: TStyle.greySemi(15)),
//                       const VerticalSpacing(16),
//                       MainButton(
//                         margin: AppConsts.defaultHorPadding,
//                         isLoading: isLoading,
//                         text: L10n.tr().tryToConnect,
//                         ontap: () => ConnectionBus.inst.checkConnection(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ));
//     });
//   }
// }
