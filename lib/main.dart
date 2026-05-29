import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/routing/app_router.dart';
import 'package:project/features/home/presentation/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      locale: const Locale('ar'),

      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },

      routerConfig: appRouter,
    );
  }
}
