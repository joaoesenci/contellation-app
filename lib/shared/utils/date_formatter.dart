import 'package:intl/intl.dart';

final class DateFormatter {
  const DateFormatter._();

  static String format(DateTime dateTime) {
    return DateFormat('MM/dd/yyy').format(dateTime);
  }
}
