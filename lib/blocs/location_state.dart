import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}
class LocationLoading extends LocationState {}
class LocationLoaded extends LocationState {
  final double lat;
  final double lon;
  const LocationLoaded(this.lat, this.lon);
  @override
  List<Object?> get props => [lat, lon];
}
class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
  @override
  List<Object?> get props => [message];
}