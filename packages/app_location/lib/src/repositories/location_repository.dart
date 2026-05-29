import '../core/failures.dart';
import '../core/result.dart';
import '../models/address_model.dart';
import '../models/location_model.dart';
import '../models/location_options.dart';
import '../models/location_permission_status.dart';

/// Contract for the location repository.
abstract class LocationRepository {
  /// Checks the current location permission.
  Future<LocationPermissionStatus> checkPermission();

  /// Requests location permission from the user.
  Future<LocationPermissionStatus> requestPermission();

  /// Opens the native OS App Settings page.
  Future<bool> openAppSettings();

  /// Checks if the GPS hardware is currently enabled.
  Future<bool> isLocationServiceEnabled();

  /// Opens the native OS Location Settings page.
  Future<bool> openLocationSettings();

  /// Requests the OS to enable the GPS service natively (inline on Android).
  Future<bool> requestServiceEnable();

  /// Orchestrates permission checks, GPS service checks, and fetches current coordinates.
  Future<Result<LocationFailure, LocationModel>> getCurrentLocation([LocationOptions options = const LocationOptions()]);

  /// Returns a continuous stream of GPS positions.
  Stream<LocationModel> getLocationStream([LocationOptions options = const LocationOptions()]);

  /// Reverse geocodes the given coordinates into a structured [AddressModel].
  Future<Result<LocationFailure, AddressModel>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  });
}
