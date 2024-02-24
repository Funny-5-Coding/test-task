import 'package:todo_test_task/models/weather_model.dart';
import 'package:todo_test_task/utilities/weather_api_provider.dart';

/// [WeatherRepository] class for getting weather data
class WeatherRepository {
  final WeatherProvider _weatherProvider = WeatherProvider();
  Future<WeatherModel> getWeather() => _weatherProvider.getWeather();
}
