import 'package:equatable/equatable.dart';

/// Pure data model for a raw location (coordinates only).
class LocationModel extends Equatable {
  final double latitude;
  final double longitude;

  const LocationModel({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
