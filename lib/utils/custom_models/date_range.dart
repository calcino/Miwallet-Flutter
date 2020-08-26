import 'package:intl/intl.dart';

class DateRange {
  String from;
  String to;

  DateRange({this.from, this.to}) {
    this.from ??= DateTime.now().subtract(Duration(days: 7)).toIso8601String();
    this.to ??= DateTime.now().toIso8601String();
  }

  @override
  String toString() {
    return '${DateFormat('yyyy MMM d').format(DateTime.parse(from))} '
        '- ${DateFormat('yyyy MMM d').format(DateTime.parse(to))}';
  }
}
