import 'package:intl/intl.dart';

extension DateTimeHelpers on DateTime {
  String toFormatDispayDateAndTime({String? format}) {
    return DateFormat(format ?? "MMM dd, yyyy hh:mm a").format(this);
  }
}
