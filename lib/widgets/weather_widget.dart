import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test_task/blocs/weather_bloc/weather_bloc.dart';
import 'package:todo_test_task/models/weather_model.dart';

/// [WeatherWidget] class for displaying weather data.
class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherLoadedState) {
          WeatherModel weather = state.weather;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather.cityName}, ${weather.description}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Temperature: ${weather.main.temp}℃'),
                          Text('Feels like: ${weather.main.feelsLike}℃'),
                          Text('Min. temperature: ${weather.main.tempMin}℃'),
                          Text('Max. temperature: ${weather.main.tempMax}℃'),
                          Text('Pressure: ${weather.main.pressure}'),
                          Text('Humidity: ${weather.main.humidity}'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wind speed: ${weather.wind.speed} meter/sec,'),
                          Text('Wind direction: ${weather.wind.deg}°'),
                          Text('Wind gust: ${weather.wind.gust} meter/sec'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherErrorState) {
          return const Center(child: Text('Could not get weather!'));
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
