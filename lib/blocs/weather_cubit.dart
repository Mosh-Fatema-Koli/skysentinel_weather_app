import 'package:bloc/bloc.dart';
import '../repository/weather_repository.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repo = WeatherRepository();

  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeather(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final weather = await _repo.getCurrentWeather(lat, lon);
      if (weather != null) emit(WeatherLoaded(weather));
      else emit(const WeatherError("Failed to fetch weather"));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}