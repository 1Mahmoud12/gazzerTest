import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/notifications/filter_item.dart';
import 'package:gazzer/features/notifications/presintation/item_notification.dart';

final AppNotification dummyNotification = AppNotification(
  title: 'Order Delivered',
  description: 'Your order #421 has been successfully delivered',
  time: '3 h',
  type: NotificationType.order,
);

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  static const route = '/notifications';
  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
  }

  NotificationType _selectedTap = NotificationType.all;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.tr().notifications, style: context.style20500)),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FilterItem(
                    title: L10n.tr().all,
                    isSelected: _selectedTap == NotificationType.all,
                    type: NotificationType.all,
                    selectedTap: (type) {
                      updateSeledtedTap(type);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterItem(
                    title: L10n.tr().orders,
                    isSelected: _selectedTap == NotificationType.order,
                    type: NotificationType.order,
                    selectedTap: (type) {
                      updateSeledtedTap(type);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterItem(
                    title: L10n.tr().offers,
                    isSelected: _selectedTap == NotificationType.offer,
                    type: NotificationType.offer,
                    selectedTap: (type) {
                      updateSeledtedTap(type);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterItem(
                    title: L10n.tr().system,
                    isSelected: _selectedTap == NotificationType.system,
                    type: NotificationType.system,
                    selectedTap: (type) {
                      updateSeledtedTap(type);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(L10n.tr().today, style: context.style20500),
            const SizedBox(height: 16),
            ItemNotification(appNotification: dummyNotification),
            const SizedBox(height: 16),

            Text(L10n.tr().previous_notification, style: context.style20500),
            const SizedBox(height: 16),
            ItemNotification(appNotification: dummyNotification),
            const SizedBox(height: 20),

            ItemNotification(appNotification: dummyNotification),
          ],
        ),
      ),
    );
  }

  void updateSeledtedTap(NotificationType type) {
    setState(() {
      _selectedTap = type;
    });
  }
}
