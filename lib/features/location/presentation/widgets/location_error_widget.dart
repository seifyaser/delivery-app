import 'package:flutter/material.dart';
import 'package:project/core/error/failures.dart';

/// Renders a contextual error card for any [LocationError] state.
///
/// - Shows a friendly Arabic message.
/// - Shows an action button whose label and callback depend on the [failure] type.
/// - [onRetry]        — re-triggers location fetch (all failures except deniedForever).
/// - [onOpenSettings] — opens App Settings (deniedForever).
/// - [onOpenLocationSettings] — opens Location Settings (service disabled).
class LocationErrorWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenSettings;
  final VoidCallback? onOpenLocationSettings;

  const LocationErrorWidget({
    super.key,
    required this.failure,
    this.onRetry,
    this.onOpenSettings,
    this.onOpenLocationSettings,
  });

  @override
  Widget build(BuildContext context) {
    final config = _resolveConfig(failure);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 6),
            color: Colors.red.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(config.icon, color: Colors.red.shade400, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            config.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            failure.message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: config.action,
              icon: Icon(config.actionIcon, size: 18),
              label: Text(config.actionLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _ErrorConfig _resolveConfig(Failure failure) {
    return switch (failure) {
      PermissionDeniedForeverFailure() => _ErrorConfig(
          icon: Icons.lock_outline,
          title: 'إذن الوصول مرفوض',
          actionLabel: 'فتح الإعدادات',
          actionIcon: Icons.settings_outlined,
          action: onOpenSettings,
        ),
      ServiceDisabledFailure() => _ErrorConfig(
          icon: Icons.location_off_outlined,
          title: 'خدمة الموقع مُعطَّلة',
          actionLabel: 'تفعيل الموقع',
          actionIcon: Icons.gps_fixed,
          action: onOpenLocationSettings,
        ),
      PermissionDeniedFailure() => _ErrorConfig(
          icon: Icons.location_disabled_outlined,
          title: 'تم رفض الإذن',
          actionLabel: 'المحاولة مرة أخرى',
          actionIcon: Icons.refresh,
          action: onRetry,
        ),
      _ => _ErrorConfig(
          icon: Icons.error_outline,
          title: 'خطأ غير متوقع',
          actionLabel: 'المحاولة مرة أخرى',
          actionIcon: Icons.refresh,
          action: onRetry,
        ),
    };
  }
}

class _ErrorConfig {
  final IconData icon;
  final String title;
  final String actionLabel;
  final IconData actionIcon;
  final VoidCallback? action;

  const _ErrorConfig({
    required this.icon,
    required this.title,
    required this.actionLabel,
    required this.actionIcon,
    required this.action,
  });
}
