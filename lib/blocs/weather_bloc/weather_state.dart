part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;
  WeatherLoadedState({required this.weather});
}

class WeatherErrorState extends WeatherState {}
