import 'package:flutter_timezone/flutter_timezone.dart';

class TimeZoneHelper {
  // Default fallback timezone if reading the device timezone fails
  static const String kFallbackTimeZone = 'Europe/Istanbul';

  /// Safely retrieves the device's timezone.
  /// Returns fallback timezone in case of any error or empty value.
  static Future<String> getSafeTimeZone() async {
    try {
      // Fetch local timezone info from device
      final TimezoneInfo info = await FlutterTimezone.getLocalTimezone();

      final id = info.identifier;

      // Use the detected timezone if valid
      if (id.isNotEmpty) {
        return id;
      }

      // Fallback for empty identifier
      return kFallbackTimeZone;
    } catch (_) {
      // Fallback in case of exceptions
      return kFallbackTimeZone;
    }
  }
}
