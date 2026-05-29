part of 'location_cubit.dart';

/// All possible states of [LocationCubit].
///
/// Each state is immutable and extends [Equatable] so BlocBuilder only
/// rebuilds when the state genuinely changes.
sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

/// The cubit has just been created — no action has been taken yet.
class LocationInitial extends LocationState {
  const LocationInitial();
}

/// Location is being resolved (permission check + GPS + geocoding).
class LocationLoading extends LocationState {
  const LocationLoading();
}

/// Location resolved successfully.
class LocationSuccess extends LocationState {
  final pkg.AddressModel location;

  const LocationSuccess(this.location);

  @override
  List<Object?> get props => [location];
}

/// Something went wrong — [failure] carries the typed reason.
class LocationError extends LocationState {
  final Failure failure;

  const LocationError(this.failure);

  @override
  List<Object?> get props => [failure];
}
