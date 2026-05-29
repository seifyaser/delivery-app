import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/routing/app_router.dart';
import 'package:project/features/home/presentation/cubit/location/location_cubit.dart';
import 'package:project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:project/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:project/features/orders/presentation/cubit/orders_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all dependencies before the widget tree is built.
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (_) => getIt<LocationCubit>()..getCurrentLocation(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => getIt<CartCubit>()..fetchCart(),
        ),
        BlocProvider<OrdersCubit>(
          create: (_) => getIt<OrdersCubit>()..fetchMyOrders(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        ),

        locale: const Locale('ar'),

        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },

        routerConfig: appRouter,
      ),
    );
  }
}

