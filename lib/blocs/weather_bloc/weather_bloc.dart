import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test_task/utilities/weather_repository.dart';

import '../../models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// [WeatherBloc] class for handling weather data.
/// Uses [WeatherRepository] for getting data.
/// Returns [WeatherState] with [WeatherLoadedState] or [WeatherErrorState]

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(WeatherLoadingState()) {
    on<GetWeather>(_onGetWeather);
  }

  void _onGetWeather(GetWeather event, emit) async {
    emit(WeatherLoadingState());
    try {
      WeatherModel weather = await weatherRepository.getWeather();
      emit(WeatherLoadedState(weather: weather));
    } catch (e) {
      emit(WeatherErrorState());
    }
  }
}
