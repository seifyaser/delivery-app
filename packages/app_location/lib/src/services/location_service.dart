import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart' as loc;
import '../models/location_model.dart';
import '../models/location_options.dart';

/// Single Responsibility: Interact with GPS hardware to retrieve coordinates.
class LocationService {
  const LocationService();

  /// Returns true if the GPS service is enabled on the device.
  Future<bool> isLocationServiceEnabled() async {
    return geo.Geolocator.isLocationServiceEnabled();
  }

  /// Requests the OS to enable the GPS service natively (inline on Android).
  Future<bool> requestServiceEnable() async {
    final locationPlugin = loc.Location();
    return locationPlugin.requestService();
  }

  /// Opens the native OS Location Settings page.
  Future<bool> openLocationSettings() {
    return geo.Geolocator.openLocationSettings();
  }

  /// Fetches a single GPS position.
  Future<LocationModel> getCurrentLocation(LocationOptions options) async {
    final position = await geo.Geolocator.getCurrentPosition(
      locationSettings: geo.LocationSettings(
        accuracy: _mapAccuracy(options.accuracy),
        timeLimit: options.timeLimit,
      ),
    );

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  /// Returns a continuous stream of GPS positions.
  Stream<LocationModel> getLocationStream(LocationOptions options) {
    return geo.Geolocator.getPositionStream(
      locationSettings: geo.LocationSettings(
        accuracy: _mapAccuracy(options.accuracy),
        distanceFilter: options.distanceFilter,
      ),
    ).map((position) => LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
  }

  geo.LocationAccuracy _mapAccuracy(LocationAccuracy appAccuracy) {
    // We map our internal LocationAccuracy enum (which has the same names as geolocator's)
    // to the actual geolocator LocationAccuracy enum.
    return geo.LocationAccuracy.values.firstWhere(
      (e) => e.name == appAccuracy.name,
      orElse: () => geo.LocationAccuracy.high,
    );
  }
}
