import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Manages environment variables.
///
/// **SECURITY NOTE**: For production web apps, DO NOT ship API keys directly
/// in the frontend code or .env file. A backend proxy should be used instead
/// to securely interact with the Gemini API. This .env setup is strictly for
/// development purposes.
class EnvManager {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String get geminiApiKey {
    const defineKey = String.fromEnvironment('GEMINI_API_KEY');
    if (defineKey.isNotEmpty) {
      print('Using GEMINI_API_KEY from dart-define: ${defineKey.substring(0, 4)}...');
      return defineKey;
    }

    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('GEMINI_API_KEY is not set in the .env file.');
    }
    print('Using GEMINI_API_KEY from .env: ${key.substring(0, 4)}...');
    return key;
  }
}
