import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_location/app_location.dart' as pkg;
import 'package:project/features/location/presentation/cubit/location_cubit.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final (mainText, subText) = _resolveTexts(state);
        final isLoading = state is LocationLoading;

        if (state is LocationSuccess) {
          debugPrint('''
════════ LOCATION ════════
FULL ADDRESS: ${state.location.fullAddress}
STREET: ${state.location.street}
AREA: ${state.location.area}
CITY: ${state.location.city}
STATE: ${state.location.state}
COUNTRY: ${state.location.country}
══════════════════════════
''');
        }

        return Container(
          height: 58,
          padding: const EdgeInsets.only(left: 4, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black.withValues(alpha: 0.12),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 38,
                height: 38,
                child: isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(9),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.deepOrange,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          context.read<LocationCubit>().getCurrentLocation();
                        },
                        padding: EdgeInsets.zero,
                        tooltip: 'تحديث الموقع',
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: 20,
                          color: state is LocationError
                              ? Colors.red.shade400
                              : Colors.grey.shade500,
                        ),
                      ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      mainText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: state is LocationError
                            ? Colors.red.shade400
                            : const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.location_on,
                color: state is LocationSuccess
                    ? Colors.deepOrange
                    : state is LocationError
                    ? Colors.red.shade300
                    : Colors.grey.shade400,
              ),
            ],
          ),
        );
      },
    );
  }


  (String, String) _resolveTexts(LocationState state) {
    return switch (state) {
      LocationSuccess(:final location) => (
        _composeMain(location),
        _composeSub(location),
      ),
      LocationLoading() => ('جاري تحديد موقعك...', 'يرجى الانتظار'),
      LocationError() => ('تعذر تحديد الموقع', 'اضغط للتحديث'),
      LocationInitial() => ('جاري التحميل...', 'الموقع الحالي'),
    };
  }

  String _composeMain(pkg.AddressModel location) {
    final street = location.street;
    final area = location.area;
    final city = location.city;
    final state = location.state;

    final parts = <String>[
      if (street?.trim().isNotEmpty == true) street!,
      if (area?.trim().isNotEmpty == true && area != street) area!,
      if (city?.trim().isNotEmpty == true && city != area && city != street)
        city!,
    ];

    if (parts.isNotEmpty) {
      return parts.join('، ');
    }

    if (state?.trim().isNotEmpty == true) {
      return state!;
    }

    return location.fullAddress;
  }

  String _composeSub(pkg.AddressModel location) {
    final state = location.state;
    final country = location.country;

    final parts = <String>[
      if (state?.trim().isNotEmpty == true) state!,
      if (country?.trim().isNotEmpty == true) country!,
    ];

    if (parts.isNotEmpty) {
      return parts.join('، ');
    }

    return 'موقعك الحالي';
  }
}
