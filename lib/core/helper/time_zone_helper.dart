import 'package:flutter_timezone/flutter_timezone.dart';

class TimeZoneHelper {
  static const String kFallbackTimeZone = 'Europe/Istanbul';

  static Future<String> getSafeTimeZone() async {
    try {
      final TimezoneInfo info = await FlutterTimezone.getLocalTimezone();

      final id = info.identifier;

      if (id.isNotEmpty) {
        return id;
      }

      return kFallbackTimeZone;
    } catch (_) {
      return kFallbackTimeZone;
    }
  }
}
