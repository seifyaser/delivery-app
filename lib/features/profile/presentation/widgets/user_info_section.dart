import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'سيف ياسر', // Placeholder name
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '+20 123 456 7890', // Placeholder phone
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
