import 'dart:io';

import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';

class ComplaintRequest {
  final int orderId;
  final List<int> orderItemIds;
  final List<int>? orderItemCounts;
  final String? note;
  final ComplaintType type;
  final File? attachment;
  final List<File>? attachments;

  ComplaintRequest({
    required this.orderId,
    required this.orderItemIds,
    this.orderItemCounts,
    this.note,
    required this.type,
    this.attachment,
    this.attachments,
  });

  bool get isValid => orderItemIds.isNotEmpty;
}
