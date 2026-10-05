// !! Not used currently but it is useable it fetches the user location and outputs a latitude/longitude
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum LocationPermissionStatus {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

abstract class LocationHandler {
  static Future<LocationPermissionStatus> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionStatus.serviceDisabled;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationPermissionStatus.denied;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionStatus.deniedForever;
    }
    return LocationPermissionStatus.granted;
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      // if (!hasPermission) return null;

      if (hasPermission != LocationPermissionStatus.granted) {
        return null;
      }

     const   LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      return position;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placeMarks[0];
      return "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
    } catch (e) {
      return null;
    }
  }

  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  static Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
