import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dateToFormattedString(String newPattern) {
    return DateFormat(newPattern).format(this);
  }

  int get numDaysInAMonth => DateTime(year, month + 1, 0).day;

  bool get isToday => difference(DateTime.now()).inDays != 0 ? false : true;

  DateTime toMidnight() {
    return DateTime(year, month, day);
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);

    return (to.difference(from).inDays / 7).ceil();
  }

  int currentWeek() {
    return weeksBetween(DateTime(year, 1, 1), this);
  }
}
