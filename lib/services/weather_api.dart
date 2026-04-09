import 'package:dio/dio.dart';
import '../utils/constants.dart';

class WeatherApi {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchCurrentWeather(double lat, double lon) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': Constants.apiKey,
        'units': 'metric'
      },
    );
    return response.data;
  }
}