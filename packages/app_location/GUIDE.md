# Architecture Guide

This package is built using Clean Architecture and SOLID principles. It is strictly separated into layers, ensuring that changes to the underlying platform packages (`geolocator`, `location`, `geocoding`) do not break the consumer app.

## Folder Structure

```
lib/
├── app_location.dart (Public exports & Facade)
├── src/
│   ├── core/
│   │   ├── result.dart (Success/Failure Wrapper)
│   │   └── failures.dart (Strongly-typed errors)
│   ├── models/ (Data Transfer Objects)
│   ├── services/ (Platform Integrations)
│   ├── repositories/ (Coordination)
│   ├── utils/
│   └── facade/
```

## Design Decisions

### 1. Composition Over Inheritance
The `LocationRepositoryImpl` uses composition to inject `LocationPermissionService`, `LocationService`, and `GeocodingService`. This makes the repository easily testable.

### 2. Result Pattern
Instead of throwing exceptions that the UI might forget to catch, this package returns a sealed `Result` class (`Success` or `FailureResult`). This forces the developer to handle both outcomes exhaustively using Dart 3 switch statements.

### 3. Separation of Packages
- `geolocator` is used for high-accuracy coordinate fetching and streams.
- `location` is used *exclusively* for its ability to trigger the native Google Play Services inline "Turn on Location?" dialog (`requestService()`), preventing the user from being thrown out of the app.
- `geocoding` is used for reverse lookup.

## Failure Handling Strategy

All platform exceptions are caught at the Repository or Service level and converted into subclasses of `LocationFailure`. 

- `PermissionDeniedFailure`: The user denied permission this time.
- `PermissionDeniedForeverFailure`: The user checked "Don't ask again". The only recovery is `openAppSettings()`.
- `LocationServiceDisabledFailure`: The GPS hardware is off, and the user declined to turn it on via the inline prompt.
- `ReverseGeocodingFailure`: Geocoding failed (e.g. no internet).
- `LocationTimeoutFailure`: GPS fetch took too long.

## Address Formatting Strategy

The raw output from `geocoding` often contains machine-readable tokens (like Google Plus Codes) in the `street` field, and duplicate fields (e.g., `locality` and `subLocality` being identical).

The `AddressFormatter` utility:
1. Strips strings matching `^[A-Z0-9]{4,8}\+[A-Z0-9]{2,7}` (Plus Codes).
2. Collects all address parts in a list.
3. Filters out nulls and empty strings.
4. Uses a `Set` to remove duplicates.
5. Joins the result with `, ` to produce a clean, delivery-friendly format.
