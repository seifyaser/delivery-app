import 'package:flutter/material.dart';
import 'package:project/features/profile/presentation/widgets/logout_button.dart';
import 'package:project/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:project/features/profile/presentation/widgets/user_info_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ProfileAvatar(),
              SizedBox(height: 24),
              UserInfoSection(),
              SizedBox(height: 60),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
