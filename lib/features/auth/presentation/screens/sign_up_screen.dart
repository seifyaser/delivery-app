import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/auth/presentation/widgets/auth_button.dart';
import 'package:project/features/auth/presentation/widgets/auth_layout.dart';
import 'package:project/features/auth/presentation/widgets/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      topIcon: Icons.person_add_alt_1,
      iconSize: 80,
      title: 'إنشاء حساب جديد',
      fields: const [
        AuthTextField(
          hintText: 'الاسم بالكامل',
          icon: Icons.person,
        ),
        SizedBox(height: 16),
        AuthTextField(
          hintText: 'البريد الإلكتروني',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        AuthTextField(
          hintText: 'رقم الهاتف',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16),
        AuthTextField(
          hintText: 'كلمة المرور',
          icon: Icons.lock,
          isPassword: true,
        ),
      ],
      actionButton: AuthButton(
        text: 'إنشاء حساب',
        onTap: () {
          context.go(RoutesPaths.home);
        },
      ),
      bottomText: 'لديك حساب بالفعل؟ ',
      bottomActionText: 'تسجيل الدخول',
      onBottomActionTap: () {
        context.pop();
      },
    );
  }
}
