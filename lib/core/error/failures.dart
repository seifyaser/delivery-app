import 'package:equatable/equatable.dart';

/// Base class for all domain-level failures.
/// Keeps raw exceptions out of the presentation layer.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// ─── Permission Failures ──────────────────────────────────────────────────────

/// User tapped "Deny" on the permission dialog.
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure()
      : super('تم رفض إذن الوصول للموقع.');
}

/// User tapped "Deny" and also checked "Don't ask again".
/// The only recovery path is opening App Settings.
class PermissionDeniedForeverFailure extends Failure {
  const PermissionDeniedForeverFailure()
      : super('تم رفض إذن الوصول للموقع بشكل دائم. يرجى تفعيله من الإعدادات.');
}

// ─── GPS / Service Failures ───────────────────────────────────────────────────

/// GPS / location services are switched off on the device.
class ServiceDisabledFailure extends Failure {
  const ServiceDisabledFailure()
      : super('خدمة الموقع معطّلة. يرجى تفعيلها من إعدادات الجهاز.');
}

// ─── Geocoding Failures ───────────────────────────────────────────────────────

/// Reverse geocoding failed to produce a usable address.
class ReverseGeocodingFailure extends Failure {
  const ReverseGeocodingFailure([super.message = 'تعذّر تحويل الإحداثيات إلى عنوان.']);
}

// ─── Generic Failures ─────────────────────────────────────────────────────────

/// Any unexpected error (network timeout, platform crash, etc.)
class LocationUnknownFailure extends Failure {
  const LocationUnknownFailure([super.message = 'حدث خطأ غير متوقع.']);
}
