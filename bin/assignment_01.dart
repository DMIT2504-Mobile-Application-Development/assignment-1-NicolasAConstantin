import 'package:assignment_01/models/current_weather.dart';
import 'package:assignment_01/services/weather_api.dart' as weather_api;

void main(List<String> arguments) async {
  final data = await weather_api.getWeatherForCity(city: 'Edmonton');
  final weather = CurrentWeather.fromOpenWeatherData(data);
https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={69e54fdcad371ca9a1a64acef3e0a654}
  print(weather);
}
