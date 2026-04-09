import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final temp = prefs.getDouble('tempThreshold') ?? 30.0;
    final rain = prefs.getBool('rainAlert') ?? true;
    emit(SettingsLoaded(temp, rain));
  }

  Future<void> updateSettings(double tempThreshold, bool rainAlert) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tempThreshold', tempThreshold);
    await prefs.setBool('rainAlert', rainAlert);
    emit(SettingsLoaded(tempThreshold, rainAlert));
  }
}