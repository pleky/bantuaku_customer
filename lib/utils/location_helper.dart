import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static final LocationHelper _instance = LocationHelper._internal();
  factory LocationHelper() {
    return _instance;
  }
  LocationHelper._internal();

  Future<Position?> getCurrentLocation() async {
    bool isLocationEnabled = await _checkLocationEnabled();
    print(isLocationEnabled);
    LocationPermission permission;

    if (!isLocationEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Future.value(position);

  }

  Future<bool> _checkLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}