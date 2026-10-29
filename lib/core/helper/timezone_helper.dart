import 'package:timezone/timezone.dart' as tz;

class EgyptTime {
  EgyptTime._();

  static final tz.Location _cairo = tz.getLocation('Africa/Cairo');

  static tz.TZDateTime now() => tz.TZDateTime.now(_cairo);
  static tz.TZDateTime from(DateTime d) =>
      tz.TZDateTime.from(d.toUtc(), _cairo);
}
