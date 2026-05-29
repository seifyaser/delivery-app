import 'dart:async';
import '../core/failures.dart';
import '../core/result.dart';
import '../models/address_model.dart';
import '../models/location_model.dart';
import '../models/location_options.dart';
import '../models/location_permission_status.dart';
import '../services/geocoding_service.dart';
import '../services/location_permission_service.dart';
import '../services/location_service.dart';
import 'location_repository.dart';

/// Concrete implementation of [LocationRepository].
/// Coordinates the three independent services.
class LocationRepositoryImpl implements LocationRepository {
  final LocationPermissionService _permissionService;
  final LocationService _locationService;
  final GeocodingService _geocodingService;

  const LocationRepositoryImpl({
    required LocationPermissionService permissionService,
    required LocationService locationService,
    required GeocodingService geocodingService,
  })  : _permissionService = permissionService,
        _locationService = locationService,
        _geocodingService = geocodingService;

  @override
  Future<LocationPermissionStatus> checkPermission() {
    return _permissionService.checkPermission();
  }

  @override
  Future<LocationPermissionStatus> requestPermission() {
    return _permissionService.requestPermission();
  }

  @override
  Future<bool> openAppSettings() {
    return _permissionService.openAppSettings();
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return _locationService.isLocationServiceEnabled();
  }

  @override
  Future<bool> requestServiceEnable() {
    return _locationService.requestServiceEnable();
  }

  @override
  Future<bool> openLocationSettings() {
    return _locationService.openLocationSettings();
  }

  @override
  Future<Result<LocationFailure, LocationModel>> getCurrentLocation([
    LocationOptions options = const LocationOptions(),
  ]) async {
    try {
      // 1. Permission Check
      final permission = await _permissionService.checkAndRequestInternal();
      if (permission == LocationPermissionStatus.denied) {
        return const FailureResult(PermissionDeniedFailure());
      }
      if (permission == LocationPermissionStatus.deniedForever) {
        return const FailureResult(PermissionDeniedForeverFailure());
      }

      // 2. Service Check
      final serviceEnabled = await _locationService.requestServiceEnable();
      if (!serviceEnabled) {
        return const FailureResult(LocationServiceDisabledFailure());
      }

      // 3. Fetch Coordinates
      final location = await _locationService.getCurrentLocation(options);
      return Success(location);
    } on TimeoutException {
      return const FailureResult(LocationTimeoutFailure());
    } catch (e) {
      return const FailureResult(LocationUnknownFailure());
    }
  }

  @override
  Stream<LocationModel> getLocationStream([
    LocationOptions options = const LocationOptions(),
  ]) {
    // The stream assumes permissions & services have already been validated.
    // Call getCurrentLocation() or handle validations before listening.
    return _locationService.getLocationStream(options);
  }

  @override
  Future<Result<LocationFailure, AddressModel>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final address = await _geocodingService.getAddressFromCoordinates(
        latitude: latitude,
        longitude: longitude,
      );
      return Success(address);
    } catch (e) {
      return const FailureResult(ReverseGeocodingFailure());
    }
  }
}

/// Extension to handle the request logic internally
extension on LocationPermissionService {
  Future<LocationPermissionStatus> checkAndRequestInternal() async {
    LocationPermissionStatus status = await checkPermission();
    if (status == LocationPermissionStatus.denied) {
      status = await requestPermission();
    }
    return status;
  }
}
