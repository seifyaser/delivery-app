# Examples

This document provides extensive usage examples for the `app_location` package.

## Core API Usage

### Get Current Location

```dart
final result = await AppLocation.instance.getCurrentLocation();
switch (result) {
  case Success(:final value):
    print("Lat: ${value.latitude}, Lng: ${value.longitude}");
  case FailureResult(:final failure):
    print("Error: ${failure.message}");
}
```

### Request Permission

```dart
final status = await AppLocation.instance.requestPermission();
if (status == LocationPermissionStatus.deniedForever) {
  await AppLocation.instance.openAppSettings();
}
```

### Open Location Settings

```dart
// Manually open the OS location settings screen
await AppLocation.instance.openLocationSettings();
```

### Get Address From Coordinates

```dart
final result = await AppLocation.instance.getAddressFromCoordinates(
  latitude: 30.0444,
  longitude: 31.2357,
);

if (result is Success<LocationFailure, AddressModel>) {
  print(result.value.fullAddress);
}
```

### Listen To Location Stream

```dart
final stream = AppLocation.instance.getLocationStream(
  const LocationOptions(distanceFilter: 10), // Update every 10 meters
);

stream.listen((location) {
  print("Moved to: ${location.latitude}, ${location.longitude}");
});
```

---

## State Management Examples

### BLoC / Cubit

```dart
class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    emit(LocationLoading());
    
    final result = await AppLocation.instance.getCurrentLocation();
    
    switch (result) {
      case Success(:final value):
        emit(LocationLoaded(value));
      case FailureResult(:final failure):
        emit(LocationError(failure));
    }
  }
}
```

### Riverpod

```dart
final locationProvider = FutureProvider<LocationModel>((ref) async {
  final result = await AppLocation.instance.getCurrentLocation();
  if (result is Success<LocationFailure, LocationModel>) {
    return result.value;
  }
  throw Exception((result as FailureResult).failure.message);
});
```

---

## Real World Examples

### Delivery App (Current Delivery Address)

```dart
Future<void> determineDeliveryAddress() async {
  final locationResult = await AppLocation.instance.getCurrentLocation();
  
  if (locationResult is Success<LocationFailure, LocationModel>) {
    final addressResult = await AppLocation.instance.getAddressFromCoordinates(
      latitude: locationResult.value.latitude,
      longitude: locationResult.value.longitude,
    );
    
    if (addressResult is Success<LocationFailure, AddressModel>) {
      // Show `addressResult.value.fullAddress` in the app header
      updateUI(addressResult.value);
    }
  }
}
```

### Ride Hailing App (Driver Tracking)

```dart
StreamSubscription? trackingSub;

void startTrip() {
  trackingSub = AppLocation.instance.getLocationStream(
    const LocationOptions(accuracy: LocationAccuracy.bestForNavigation)
  ).listen((location) {
    // Send location to backend websocket
    socket.emit('driver_location', location.toJson());
  });
}

void endTrip() {
  trackingSub?.cancel();
}
```

---

## Error Handling Examples

Use pattern matching to handle specific failures elegantly.

```dart
final result = await AppLocation.instance.getCurrentLocation();

if (result is FailureResult) {
  final failure = result.failure;
  
  if (failure is PermissionDeniedForeverFailure) {
    showDialog(
      title: 'Action Required',
      content: 'Please open settings to enable location',
      action: AppLocation.instance.openAppSettings,
    );
  } else if (failure is ServiceDisabledFailure) {
    showToast('Please enable GPS to continue.');
  } else {
    showToast(failure.message);
  }
}
```

---

## Future Extensions

Because the package uses `Clean Architecture`, it can easily be extended by modifying the `LocationRepositoryImpl`:

- **Background Tracking**: Swap out `geolocator` for `flutter_background_geolocation` in the `LocationService` without touching the consumer app.
- **Mapbox Integration**: Add a `MapboxGeocodingService` that implements the same contract as `GeocodingService` and inject it into the repository.
