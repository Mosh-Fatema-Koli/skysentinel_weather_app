import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_cubit.dart';
import '../blocs/weather_state.dart';


class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("5-Day Forecast")),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final forecastList = state.weather.forecast ?? [];
            if (forecastList.isEmpty) {
              return const Center(child: Text("No forecast data available"));
            }
            return ListView.builder(
              itemCount: forecastList.length,
              itemBuilder: (context, index) {
                final day = forecastList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(_weatherIcon(day.condition)),
                    title: Text("${day.date}"),
                    subtitle: Text("Temp: ${day.temp}°C, ${day.condition}"),
                  ),
                );
              },
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  IconData _weatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
        return Icons.umbrella;
      case 'clouds':
        return Icons.cloud;
      case 'clear':
        return Icons.wb_sunny;
      default:
        return Icons.wb_cloudy;
    }
  }
}