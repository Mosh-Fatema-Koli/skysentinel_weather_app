import 'package:dio/dio.dart';
import '../models/weather_model.dart';
import '../services/weather_api.dart';

class WeatherRepository {
  final WeatherApi _api = WeatherApi();

  Future<WeatherModel?> getCurrentWeather(double lat, double lon) async {
    try {
      final response = await _api.fetchCurrentWeather(lat, lon);
      return WeatherModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}