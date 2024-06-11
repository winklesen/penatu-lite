import 'package:logger/logger.dart';

/// Debug Helper
var log = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  output: null, // Use the default LogOutput (-> send everything to console)
  printer: PrettyPrinter(
      methodCount: 0,
      // number of method calls to be displayed,  8
      errorMethodCount: 3,
      // number of method calls if stacktrace is provided, // default
      lineLength: 60,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);
