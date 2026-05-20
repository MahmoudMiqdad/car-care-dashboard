import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get baseUrl {
    final value = dotenv.env['BASE_URL'];
    if (value == null || value.isEmpty) {
      throw Exception('BASE_URL is not defined in .env file.');
    }
    return value;
  }

  static String get reverbKey {
    return dotenv.env['REVERB_KEY'] ?? 'qvu5rzruhum2kkuf6vyg';
  }

  static String get reverbHost {
    return dotenv.env['REVERB_HOST'] ?? '10.95.236.103';
  }

  static int get reverbPort {
    return int.tryParse(dotenv.env['REVERB_PORT'] ?? '8080') ?? 8080;
  }
}