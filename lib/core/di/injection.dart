import 'package:get_it/get_it.dart';
import 'package:project/features/location/presentation/cubit/location_cubit.dart';

/// Global service locator instance.
final GetIt getIt = GetIt.instance;

/// Registers all dependencies before [runApp].
///
/// Registration strategy:
///  - [LocationCubit] → factory (new instance per screen, owns UI state)
void setupLocator() {
  // ── Presentation Layer ──────────────────────────────────────────────────────
  // Factory: each screen gets its own cubit instance.
  getIt.registerFactory<LocationCubit>(
    () => LocationCubit(),
  );
}
