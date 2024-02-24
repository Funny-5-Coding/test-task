import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_test_task/models/weather_model.dart';
import 'package:todo_test_task/utilities/constants.dart';
import 'package:todo_test_task/utilities/location.dart';

/**
 * For getting weather data from OpenWeatherMap
 * uses [http] package for http requests
 * because of simplicity and readability of getting data 
 */

/// [WeatherProvider] class for fetching weather data.
/// Returnes [WeatherModel].
class WeatherProvider {
  Future<WeatherModel> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final response = await http.get(Uri.parse(
        '${Constants.weatherUrl}/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=${Constants.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      final weatherJson = json.decode(response.body);

      return WeatherModel.fromJson(weatherJson);
    } else {
      throw Exception('Error getting weather');
    }
  }
}
