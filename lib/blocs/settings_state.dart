import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}
class SettingsLoaded extends SettingsState {
  final double tempThreshold;
  final bool rainAlert;
  const SettingsLoaded(this.tempThreshold, this.rainAlert);
  @override
  List<Object?> get props => [tempThreshold, rainAlert];
}