import 'package:geocoding/geocoding.dart';
import '../models/address_model.dart';
import '../utils/address_formatter.dart';

/// Single Responsibility: Convert GPS coordinates to human-readable addresses.
class GeocodingService {
  const GeocodingService();

  /// Reverse geocodes the given coordinates.
  /// Falls back to a basic formatted string of coordinates if geocoding yields no results.
  Future<AddressModel> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return _fallback(latitude, longitude);
      }

      final p = placemarks.first;
      final street = AddressFormatter.cleanPlusCode(p.street);

      final fullAddress = AddressFormatter.formatFullAddress([
        p.name,
        street,
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.country,
      ]);

      return AddressModel(
        latitude: latitude,
        longitude: longitude,
        fullAddress: fullAddress,
        street: street,
        area: p.subLocality,
        city: p.locality,
        state: p.administrativeArea,
        country: p.country,
        postalCode: p.postalCode,
      );
    } catch (_) {
      // In case of geocoding network errors, fallback to raw coordinates
      return _fallback(latitude, longitude);
    }
  }

  AddressModel _fallback(double lat, double lng) {
    return AddressModel(
      latitude: lat,
      longitude: lng,
      fullAddress: '$lat, $lng',
    );
  }
}
