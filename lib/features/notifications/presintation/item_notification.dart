import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

class AppNotification {
  final String title;
  final String description;
  final String time;
  final NotificationType type;

  AppNotification({required this.title, required this.description, required this.time, required this.type});
}

class ItemNotification extends StatefulWidget {
  const ItemNotification({super.key, required this.appNotification});

  final AppNotification appNotification;

  @override
  State<ItemNotification> createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Co.w900, borderRadius: BorderRadius.all(Radius.circular(24))),

      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: SizedBox(width: 20, height: 20, child: VectorGraphicsWidget(widget.appNotification.type.asset, fit: BoxFit.none)),
        ),
        title: Text(widget.appNotification.title, style: TStyle.robotBlackMedium()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.appNotification.description, style: TStyle.robotBlackRegular().copyWith(color: Co.darkGrey)),
            SizedBox(height: 4),
            Text(widget.appNotification.time, style: context.style14400.copyWith(color: Co.darkGrey)),
          ],
        ),

        trailing: InkWell(
          onTap: () {
            // Handle tap on more horizontal icon
          },
          child: const VectorGraphicsWidget(Assets.moreHorizontal),
        ),
      ),
    );
  }
}
