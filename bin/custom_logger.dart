import 'package:logger/logger.dart';

class CustomLogger {
  static Logger normal = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static Logger simple = Logger(
    printer: SimplePrinter(colors: true),
  );

  static Logger trace = Logger(
    printer: PrettyPrinter(),
  );

}