import 'package:core/utils/shared.dart';
import 'package:http/http.dart' as http;

/// reference https://www.dicoding.com/academies/199/discussions/136107
class SSLHelper {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await Shared.createLEClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
