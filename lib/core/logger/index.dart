import "package:e_commerce/config/path_export.dart";
import 'dart:developer';
class Logger {
  static debug(String title, [dynamic message]) {
    if (kDebugMode) {
      if (message != null) {
        log("$title -> $message");
      } else {
        log(title);
      }
    }
  }

  static error(Object error) {
    log(error.toString());
  }
}
