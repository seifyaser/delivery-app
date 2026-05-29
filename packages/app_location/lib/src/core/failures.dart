import 'package:equatable/equatable.dart';

/// Base class for all location-related failures.
abstract class LocationFailure extends Equatable {
  final String message;

  const LocationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// User tapped "Deny" on the permission dialog.
class PermissionDeniedFailure extends LocationFailure {
  const PermissionDeniedFailure([super.message = 'Location permission denied.']);
}

/// User tapped "Deny" and checked "Don't ask again".
/// Requires opening App Settings.
class PermissionDeniedForeverFailure extends LocationFailure {
  const PermissionDeniedForeverFailure([super.message = 'Location permission permanently denied. Please enable in settings.']);
}

/// GPS / location services are disabled on the device.
class LocationServiceDisabledFailure extends LocationFailure {
  const LocationServiceDisabledFailure([super.message = 'Location services are disabled.']);
}

/// Reverse geocoding failed to produce an address.
class ReverseGeocodingFailure extends LocationFailure {
  const ReverseGeocodingFailure([super.message = 'Could not determine address from coordinates.']);
}

/// GPS fetch timed out.
class LocationTimeoutFailure extends LocationFailure {
  const LocationTimeoutFailure([super.message = 'Location request timed out.']);
}

/// Any unexpected error.
class LocationUnknownFailure extends LocationFailure {
  const LocationUnknownFailure([super.message = 'An unknown location error occurred.']);
}
