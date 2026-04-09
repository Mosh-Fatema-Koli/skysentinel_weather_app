import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysentinel/screen/dashboard_screen.dart';
import 'package:skysentinel/services/notification_services.dart';
import 'blocs/weather_cubit.dart';
import 'blocs/location_cubit.dart';
import 'blocs/settings_cubit.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationService().init();
    print("Background fetch executed: $task");
    // You can fetch weather & trigger notifications here
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "weatherBackgroundTask",
    "fetchWeather",
    frequency: const Duration(minutes: 15),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(create: (_) => WeatherCubit()),
        BlocProvider(create: (_) => SettingsCubit()..loadSettings()),
      ],
      child: const SkySentinelApp(),
    ),
  );
}

class SkySentinelApp extends StatelessWidget {
  const SkySentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkySentinel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardScreen(),
    );
  }
}