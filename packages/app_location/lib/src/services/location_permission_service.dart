import 'package:geolocator/geolocator.dart';
import '../models/location_permission_status.dart';

/// Single Responsibility: Manage OS location permissions.
class LocationPermissionService {
  const LocationPermissionService();

  /// Checks the current location permission status.
  Future<LocationPermissionStatus> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return _mapPermission(permission);
  }

  /// Prompts the user for location permission.
  Future<LocationPermissionStatus> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return _mapPermission(permission);
  }

  /// Opens the native OS App Settings page.
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  LocationPermissionStatus _mapPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.granted;
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.denied;
    }
  }
}
