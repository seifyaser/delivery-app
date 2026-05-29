import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: const NetworkImage(
            'https://i.pravatar.cc/300', // Placeholder image
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Color(0xffF7F4F4),
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
