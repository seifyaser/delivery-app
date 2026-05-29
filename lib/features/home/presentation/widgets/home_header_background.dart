import 'package:flutter/material.dart';

class HomeHeaderBackground extends StatelessWidget {
  const HomeHeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: Image.asset(
              'assets/images/homeHeader.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        /// Overlay
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.25),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
        ),
      ],
    );
  }
}
