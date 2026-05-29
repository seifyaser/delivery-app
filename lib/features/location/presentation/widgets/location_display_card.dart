import 'package:flutter/material.dart';
import 'package:app_location/app_location.dart' as pkg;

/// Displays the resolved address in a structured card.
///
/// Each address component (street, area, city, state, country) is shown
/// on its own line when available, falling back to [fullAddress] otherwise.
class LocationDisplayCard extends StatelessWidget {
  final pkg.AddressModel location;

  const LocationDisplayCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.07),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.deepOrange,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'الموقع الحالي',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Granular address components
          _AddressRow(
            icon: Icons.signpost_outlined,
            label: 'الشارع',
            value: location.street,
          ),
          _AddressRow(
            icon: Icons.location_city_outlined,
            label: 'الحي / المنطقة',
            value: location.area,
          ),
          _AddressRow(
            icon: Icons.apartment_outlined,
            label: 'المدينة',
            value: location.city,
          ),
          _AddressRow(
            icon: Icons.map_outlined,
            label: 'المحافظة',
            value: location.state,
          ),
          _AddressRow(
            icon: Icons.flag_outlined,
            label: 'الدولة',
            value: location.country,
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Full address as one line
          Text(
            location.fullAddress,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              height: 1.6,
            ),
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 8),

          // GPS coordinates
          Text(
            '${location.latitude.toStringAsFixed(4)}, '
            '${location.longitude.toStringAsFixed(4)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade400,
              fontFeatures: [],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _AddressRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.deepOrange.shade300),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF1A1A2E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
