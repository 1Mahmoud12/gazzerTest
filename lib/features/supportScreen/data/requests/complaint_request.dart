import 'dart:io';

import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';

class ComplaintRequest {
  final int orderId;
  final List<int> orderItemIds;
  final String? note;
  final ComplaintType type;
  final File? attachment;

  ComplaintRequest({
    required this.orderId,
    required this.orderItemIds,
    this.note,
    required this.type,
    this.attachment,
  });

  bool get isValid => orderItemIds.isNotEmpty;
}
