import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/auth/presentation/widgets/auth_button.dart';
import 'package:project/features/auth/presentation/widgets/auth_layout.dart';
import 'package:project/features/auth/presentation/widgets/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      topIcon: Icons.fastfood,
      title: 'تسجيل الدخول',
      fields: const [
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
        text: 'تسجيل الدخول',
        onTap: () {
          context.go(RoutesPaths.home);
        },
      ),
      bottomText: 'ليس لديك حساب؟ ',
      bottomActionText: 'إنشاء حساب',
      onBottomActionTap: () {
        context.push(RoutesPaths.signUp);
      },
    );
  }
}
