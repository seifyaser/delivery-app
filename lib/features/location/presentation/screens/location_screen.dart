import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/features/location/presentation/cubit/location_cubit.dart';
import 'package:project/features/location/presentation/widgets/location_display_card.dart';
import 'package:project/features/location/presentation/widgets/location_error_widget.dart';

/// The dedicated location screen.
///
/// Provides its own [LocationCubit] via [BlocProvider].
/// The screen is intentionally thin — all state transitions
/// are delegated to the cubit.
class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  static const routePath = '/location';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationCubit>(),
      child: const _LocationView(),
    );
  }
}

class _LocationView extends StatelessWidget {
  const _LocationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الموقع الحالي',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
            fontSize: 18,
          ),
        ),
        leading: const BackButton(color: Color(0xFF1A1A2E)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── State display area ──────────────────────────────────
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: _buildStateContent(context, state),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Primary action button ───────────────────────────────
                  _GetLocationButton(isLoading: state is LocationLoading),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStateContent(BuildContext context, LocationState state) {
    return switch (state) {
      LocationInitial() => const _InitialPrompt(),
      LocationLoading() => const _LoadingIndicator(),
      LocationSuccess(:final location) => LocationDisplayCard(
          key: const ValueKey('success'),
          location: location,
        ),
      LocationError(:final failure) => LocationErrorWidget(
          key: const ValueKey('error'),
          failure: failure,
          onRetry: () => context.read<LocationCubit>().getCurrentLocation(),
          onOpenSettings: () =>
              context.read<LocationCubit>().openAppSettings(),
          onOpenLocationSettings: () =>
              context.read<LocationCubit>().openLocationSettings(),
        ),
    };
  }
}

// ─── Sub-widgets ───────────────────────────────────────────────────────────────

class _InitialPrompt extends StatelessWidget {
  const _InitialPrompt();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('initial'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.deepOrange.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_searching,
              size: 56,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'اعرف موقعك الآن',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'اضغط الزر أدناه للحصول على موقعك الحالي\nوعنوانك بالتفصيل',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                  height: 1.7,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('loading'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'جاري تحديد موقعك...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _GetLocationButton extends StatelessWidget {
  final bool isLoading;

  const _GetLocationButton({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton.icon(
        onPressed: isLoading
            ? null
            : () => context.read<LocationCubit>().getCurrentLocation(),
        icon: const Icon(Icons.my_location, size: 20),
        label: const Text(
          'الحصول على الموقع الحالي',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.deepOrange,
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: Colors.deepOrange.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
