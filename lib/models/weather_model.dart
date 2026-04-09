class WeatherForecast {
  final String date;
  final double temp;
  final String condition;

  WeatherForecast({
    required this.date,
    required this.temp,
    required this.condition,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['dt_txt'] ?? '', // OpenWeatherMap 5-day API
      temp: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'] as String,
    );
  }
}

class WeatherModel {
  final double temp;
  final String condition;
  final List<WeatherForecast> forecast; // 5-day forecast

  WeatherModel({
    required this.temp,
    required this.condition,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // Current weather
    final currentTemp = (json['main']['temp'] as num).toDouble();
    final currentCondition = json['weather'][0]['main'] as String;

    // 5-day forecast (from "list" key in forecast API response)
    final forecastList = <WeatherForecast>[];
    if (json['list'] != null) {
      for (var item in json['list']) {
        forecastList.add(WeatherForecast.fromJson(item));
      }
    }

    return WeatherModel(
      temp: currentTemp,
      condition: currentCondition,
      forecast: forecastList,
    );
  }
}