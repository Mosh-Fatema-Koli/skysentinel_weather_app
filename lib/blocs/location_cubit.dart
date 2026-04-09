import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  /// Get current location coordinates
  Future<Position?> getCurrentLocation() async {
    emit(LocationLoading());

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception("Location services are disabled");

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permission permanently denied");
      }

      // Get current position
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(LocationLoaded(pos.latitude, pos.longitude));
      return pos; // return Position for further use

    } catch (e) {
      emit(LocationError(e.toString()));
      return null;
    }
  }
}