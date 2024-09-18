const durationFromStringExtension = '''
extension DurationFromString on Duration {
  static Duration fromString(String str) {
    final parts = str.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final secondsAndMilliseconds = parts[2].split('.');
    final seconds = int.parse(secondsAndMilliseconds[0]);
    final milliseconds = secondsAndMilliseconds.length > 1
      ? int.parse(secondsAndMilliseconds[1])
      : 0;

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}
''';
