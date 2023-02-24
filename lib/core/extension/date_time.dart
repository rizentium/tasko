import 'package:intl/intl.dart';

extension DateTimeExtended on DateTime {
  String toReadableFormat() => DateFormat("MMMM dd, yyyy HH:mm").format(this);
}
