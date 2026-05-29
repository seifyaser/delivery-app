import '../core/failures.dart';
import '../core/result.dart';
import '../models/address_model.dart';
import '../models/location_model.dart';
import '../models/location_options.dart';
import '../models/location_permission_status.dart';
import '../repositories/location_repository.dart';
import '../repositories/location_repository_impl.dart';
import '../services/geocoding_service.dart';
import '../services/location_permission_service.dart';
import '../services/location_service.dart';

/// Single entry point for the `app_location` package.
///
/// Implemented as a singleton facade to hide the internal initialization
/// of services and repositories from the consumer app.
class AppLocation {
  AppLocation._internal() {
    _repository = const LocationRepositoryImpl(
      permissionService: LocationPermissionService(),
      locationService: LocationService(),
      geocodingService: GeocodingService(),
    );
  }

  static final AppLocation _instance = AppLocation._internal();

  /// Gets the singleton instance of [AppLocation].
  static AppLocation get instance => _instance;

  late final LocationRepository _repository;

  /// Checks the current location permission.
  Future<LocationPermissionStatus> checkPermission() =>
      _repository.checkPermission();

  /// Requests location permission from the user.
  Future<LocationPermissionStatus> requestPermission() =>
      _repository.requestPermission();

  /// Opens the native OS App Settings page.
  Future<bool> openAppSettings() => _repository.openAppSettings();

  /// Checks if the GPS hardware is currently enabled.
  Future<bool> isLocationServiceEnabled() =>
      _repository.isLocationServiceEnabled();

  /// Opens the native OS Location Settings page.
  Future<bool> openLocationSettings() => _repository.openLocationSettings();

  /// Requests the OS to enable the GPS service natively (inline on Android).
  Future<bool> requestServiceEnable() => _repository.requestServiceEnable();

  /// Orchestrates permission checks, GPS service checks, and fetches current coordinates.
  ///
  /// Returns a [Result] containing either a [LocationFailure] or a [LocationModel].
  Future<Result<LocationFailure, LocationModel>> getCurrentLocation([
    LocationOptions options = const LocationOptions(),
  ]) =>
      _repository.getCurrentLocation(options);

  /// Returns a continuous stream of GPS positions.
  ///
  /// Note: Make sure to check permissions and ensure GPS service is enabled before listening.
  Stream<LocationModel> getLocationStream([
    LocationOptions options = const LocationOptions(),
  ]) =>
      _repository.getLocationStream(options);

  /// Reverse geocodes the given coordinates into a structured [AddressModel].
  Future<Result<LocationFailure, AddressModel>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) =>
      _repository.getAddressFromCoordinates(
        latitude: latitude,
        longitude: longitude,
      );
}
