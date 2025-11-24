enum ComplaintType {
  missingItems,
  wrongItems,
  incorrect,
  damagedItems,
  lateDelivery,
  qualityIssue,
  chat,
  other;

  String get value {
    switch (this) {
      case ComplaintType.missingItems:
        return 'missing_items';
      case ComplaintType.wrongItems:
        return 'wrong_items';
      case ComplaintType.incorrect:
        return 'incorrect';
      case ComplaintType.damagedItems:
        return 'damaged_items';
      case ComplaintType.lateDelivery:
        return 'late_delivery';
      case ComplaintType.qualityIssue:
        return 'quality_issue';
      case ComplaintType.chat:
        return 'chat';
      case ComplaintType.other:
        return 'other';
    }
  }
}

enum OrderIssueType {
  missing,
  incorrect,
  chat,
}

enum CategoryType {
  general,
  orderIssue;

  String get value {
    switch (this) {
      case CategoryType.general:
        return 'general';
      case CategoryType.orderIssue:
        return 'order_issue';
    }
  }
}
