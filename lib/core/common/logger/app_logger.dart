import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Global logger accessor
class AppLogger {
  static Logger get logger => GetIt.instance<Logger>();
}
