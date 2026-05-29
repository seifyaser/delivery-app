import 'package:equatable/equatable.dart';

/// Defines the accuracy requirements and timeouts for a location request.
class LocationOptions extends Equatable {
  /// The desired accuracy of the location.
  final LocationAccuracy accuracy;

  /// Maximum time to wait for a location before throwing [LocationTimeoutFailure].
  final Duration? timeLimit;

  /// The minimum distance (in meters) the device must move before an update is triggered (used for streams).
  final int distanceFilter;

  const LocationOptions({
    this.accuracy = LocationAccuracy.high,
    this.timeLimit = const Duration(seconds: 15),
    this.distanceFilter = 0,
  });

  @override
  List<Object?> get props => [accuracy, timeLimit, distanceFilter];
}

/// Abstract representation of location accuracy to avoid leaking geolocator types.
enum LocationAccuracy {
  lowest,
  low,
  medium,
  high,
  best,
  bestForNavigation,
}
