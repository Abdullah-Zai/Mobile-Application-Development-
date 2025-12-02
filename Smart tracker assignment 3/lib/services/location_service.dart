import 'package:geolocator/geolocator.dart';

class LocationService {
  // Check and request permission
  static Future<bool> requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false; // GPS OFF
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false; // user blocked permission in settings
    }

    return true;
  }

  // Get current position
  static Future<Position?> getCurrentLocation() async {
    bool allowed = await requestPermission();
    if (!allowed) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
