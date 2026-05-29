import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/error/failures.dart';
import 'package:app_location/app_location.dart' as pkg;

part 'location_state.dart';

/// Orchestrates the location-fetching flow.
///
/// Uses the [app_location] package to fetch coordinates and address.
class LocationCubit extends Cubit<LocationState> {
  static const _tag = 'LocationCubit';

  LocationCubit() : super(const LocationInitial()) {
    log('initialized', name: _tag);
  }

  /// Triggers the full location resolution flow.
  Future<void> getCurrentLocation() async {
    log('▶ getCurrentLocation() — emitting LocationLoading', name: _tag);
    emit(const LocationLoading());

    // 1. Fetch Coordinates
    final locationResult = await pkg.AppLocation.instance.getCurrentLocation();

    if (locationResult is pkg.FailureResult<pkg.LocationFailure, pkg.LocationModel>) {
      final failure = _mapPackageFailure(locationResult.failure);
      log('✗ emitting LocationError — [${failure.runtimeType}] ${failure.message}', name: _tag);
      emit(LocationError(failure));
      return;
    }

    // 2. Reverse Geocode Coordinates
    final location = (locationResult as pkg.Success<pkg.LocationFailure, pkg.LocationModel>).value;
    
    final addressResult = await pkg.AppLocation.instance.getAddressFromCoordinates(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    if (addressResult is pkg.FailureResult<pkg.LocationFailure, pkg.AddressModel>) {
      final failure = _mapPackageFailure(addressResult.failure);
      log('✗ emitting LocationError — [${failure.runtimeType}] ${failure.message}', name: _tag);
      emit(LocationError(failure));
      return;
    }

    final address = (addressResult as pkg.Success<pkg.LocationFailure, pkg.AddressModel>).value;
    log('✔ emitting LocationSuccess — "${address.fullAddress}"', name: _tag);
    emit(LocationSuccess(address));
  }

  /// Opens the device's Location Settings (GPS on/off).
  Future<void> openLocationSettings() {
    log('→ openLocationSettings() triggered by UI', name: _tag);
    return pkg.AppLocation.instance.openLocationSettings();
  }

  /// Opens the app's Settings page (for permanently denied permission).
  Future<void> openAppSettings() {
    log('→ openAppSettings() triggered by UI', name: _tag);
    return pkg.AppLocation.instance.openAppSettings();
  }

  /// Maps the package's LocationFailure to our app's localized Failure classes.
  Failure _mapPackageFailure(pkg.LocationFailure packageFailure) {
    return switch (packageFailure) {
      pkg.PermissionDeniedFailure() => const PermissionDeniedFailure(),
      pkg.PermissionDeniedForeverFailure() => const PermissionDeniedForeverFailure(),
      pkg.LocationServiceDisabledFailure() => const ServiceDisabledFailure(),
      pkg.ReverseGeocodingFailure() => const ReverseGeocodingFailure(),
      _ => const LocationUnknownFailure(),
    };
  }
}
