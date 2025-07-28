import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get defaultTimeFormat => DateFormat.jm().format(this);
}
