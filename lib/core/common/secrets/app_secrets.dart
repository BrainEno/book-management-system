import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String? dbName = dotenv.env['DB_NAME'];
}
