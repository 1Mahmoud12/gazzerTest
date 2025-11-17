import 'package:flutter/material.dart';

enum OrderStatus {
  delivered,
  cancelled,
  preparing,
  pending,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.pending:
        return 'Pending';
    }
  }

  Color get badgeColor {
    switch (this) {
      case OrderStatus.delivered:
        return const Color(0xFFE8F5E9); // Light green
      case OrderStatus.cancelled:
        return const Color(0xFFFFE1E1); // Light pink
      case OrderStatus.preparing:
        return const Color(0xFFFFF3E0); // Light orange
      case OrderStatus.pending:
        return const Color(0xFFE3F2FD); // Light blue
    }
  }
}
