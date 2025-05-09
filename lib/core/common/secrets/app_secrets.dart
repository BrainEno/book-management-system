import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String? dbName = dotenv.env['DB_NAME'];
  static String? defaultPWD = dotenv.env['DEFAULT_PWD'];
  static String? serviceType = dotenv.env['SERVICE_TYPE'];
  static int servicePort =
      int.tryParse(dotenv.env['SERVICE_PORT'] ?? '8080') ?? 8080;
}
