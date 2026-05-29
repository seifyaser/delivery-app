# App Location Package

A robust, production-ready, framework-agnostic location infrastructure package for Flutter.

This internal package abstracts away complex GPS hardware interactions, permission flows, and reverse geocoding into a clean, strongly-typed API based on Clean Architecture principles.

## Features

- **Permission Management**: Safely request and check permissions. Handles the permanently denied edge-case gracefully.
- **GPS Service Check**: Native inline dialogs on Android to ask the user to turn on GPS without leaving the app.
- **Reverse Geocoding**: Automatically cleans up Google Plus Codes and formats delivery-friendly addresses.
- **Framework Agnostic**: Pure Dart/Flutter. Use it with BLoC, Riverpod, Provider, GetX, or no state management at all.
- **Failure Types**: Strongly-typed `Result` wrappers so your presentation layer never catches raw `PlatformException`s.

## Installation

Add the following to your consumer app's `pubspec.yaml`:

```yaml
dependencies:
  app_location:
    path: ./packages/app_location
```

Ensure you have configured Android and iOS permissions in your host application according to the underlying `geolocator` and `location` package requirements.

## Quick Start

### Get Current Location

```dart
import 'package:app_location/app_location.dart';

Future<void> fetchLocation() async {
  final result = await AppLocation.instance.getCurrentLocation();

  switch (result) {
    case Success(:final value):
      print('Location found: ${value.latitude}, ${value.longitude}');
    case FailureResult(:final failure):
      print('Failed: ${failure.message}');
  }
}
```

### Get Formatted Address

```dart
final result = await AppLocation.instance.getAddressFromCoordinates(
  latitude: 30.0444,
  longitude: 31.2357,
);

if (result is Success<LocationFailure, AddressModel>) {
  print(result.value.fullAddress); 
}
```

## API Reference

The primary entry point is the singleton `AppLocation.instance`. 

For full architectural details, see [GUIDE.md](GUIDE.md).
For extensive usage examples, see [EXAMPLES.md](EXAMPLES.md).
