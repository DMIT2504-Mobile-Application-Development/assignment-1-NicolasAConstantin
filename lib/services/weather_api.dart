import 'dart:convert';
import 'package:http/http.dart' as http;

const String weatherApiKey = '69e54fdcad371ca9a1a64acef3e0a654';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final url = Uri.parse('$currentWeatherEndpoint?units=metric&q=$city&appid=$weatherApiKey');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('There was a problem with the request: status ${response.statusCode} received.');
    }
  } catch (e) {
    throw Exception('There was a problem with the request: $e');
  }
}
