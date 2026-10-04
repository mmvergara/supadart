const durationFromStringExtension = r'''
extension DurationFromString on Duration {
  /// Parses an interval in Postgres' default IntervalStyle, such as
  /// "04:05:06.5", "3 days" or "1 year 2 mons -3 days +04:05:06".
  ///
  /// Months and years have no fixed length. As in Postgres' extract(epoch),
  /// a month counts as 30 days and a year as 365.25 days.
  static Duration fromString(String str) {
    final part = RegExp(r'([+-]?\d+) (year|mon|day)s?'
        r'|([+-]?)(\d+):(\d+):(\d+)(?:\.(\d+))?');
    if (str.replaceAll(part, '').trim().isNotEmpty) {
      throw FormatException('Unsupported interval format', str);
    }

    const day = Duration.microsecondsPerDay;
    var micros = 0;
    for (final m in part.allMatches(str)) {
      if (m[1] != null) {
        final n = int.parse(m[1]!);
        micros += switch (m[2]) {
          'year' => n * day * 1461 ~/ 4,
          'mon' => n * day * 30,
          _ => n * day,
        };
      } else {
        final fraction = (m[7] ?? '').padRight(6, '0').substring(0, 6);
        final time = int.parse(m[4]!) * Duration.microsecondsPerHour +
            int.parse(m[5]!) * Duration.microsecondsPerMinute +
            int.parse(m[6]!) * Duration.microsecondsPerSecond +
            int.parse(fraction);
        micros += m[3] == '-' ? -time : time;
      }
    }
    return Duration(microseconds: micros);
  }
}
''';
