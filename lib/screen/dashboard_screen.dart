import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_cubit.dart';
import '../blocs/location_cubit.dart';
import '../blocs/weather_state.dart';
import 'forecast_screen.dart';
import 'alert_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final locationCubit = context.read<LocationCubit>();
    final weatherCubit = context.read<WeatherCubit>();

    // Fetch location first
    locationCubit.getCurrentLocation().then((coords) {
      if (coords != null) {
        weatherCubit.fetchWeather(coords.latitude, coords.longitude);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkySentinel Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AlertScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForecastScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const CircularProgressIndicator();
            } else if (state is WeatherLoaded) {
              final weather = state.weather;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weather.temp.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    weather.condition,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForecastScreen()),
                      );
                    },
                    child: const Text('View 5-Day Forecast'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AlertScreen()),
                      );
                    },
                    child: const Text('View Alerts'),
                  ),
                ],
              );
            } else if (state is WeatherError) {
              return Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              );
            } else {
              return const Text('Please wait...');
            }
          },
        ),
      ),
    );
  }
}