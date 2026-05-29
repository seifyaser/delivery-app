/// Represents the current status of location permission.
enum LocationPermissionStatus {
  /// Permission is granted.
  granted,
  /// Permission is denied, but can be requested again.
  denied,
  /// Permission is permanently denied; requires opening app settings.
  deniedForever,
}
