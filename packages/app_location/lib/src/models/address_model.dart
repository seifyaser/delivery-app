import 'package:equatable/equatable.dart';

/// Data model representing a structured human-readable address.
class AddressModel extends Equatable {
  final double latitude;
  final double longitude;
  final String fullAddress;

  final String? street;
  final String? area;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  const AddressModel({
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    this.street,
    this.area,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        fullAddress,
        street,
        area,
        city,
        state,
        country,
        postalCode,
      ];
}
