import 'package:flutter/foundation.dart';

/// A simple utility class for printing debug messages clearly.
class DebugLoggerHelper {
  /// Prints a formatted debug message only in debug mode.
  static void log(String message) {
    if (kDebugMode) {
      print("📌 DEBUG LOG: $message");
    }
  }
}
