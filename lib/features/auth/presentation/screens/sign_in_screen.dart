import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/auth/presentation/widgets/auth_button.dart';
import 'package:project/features/auth/presentation/widgets/auth_layout.dart';
import 'package:project/features/auth/presentation/widgets/auth_text_field.dart';

import '../cubit/auth_cubit.dart';
import '../../data/models/auth_models.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(RoutesPaths.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return AuthLayout(
          formKey: _formKey,
          topIcon: Icons.fastfood,
          title: 'تسجيل الدخول',
          fields: [
            AuthTextField(
              name: 'email',
              hintText: 'البريد الإلكتروني',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'هذا الحقل مطلوب'),
                FormBuilderValidators.email(errorText: 'بريد إلكتروني غير صالح'),
              ]),
            ),
            const SizedBox(height: 16),
            AuthTextField(
              name: 'password',
              hintText: 'كلمة المرور',
              icon: Icons.lock,
              isPassword: true,
              validator: FormBuilderValidators.required(errorText: 'هذا الحقل مطلوب'),
            ),
          ],
          actionButton: AuthButton(
            text: isLoading ? 'جاري التحميل...' : 'تسجيل الدخول',
            onTap: isLoading
                ? () {}
                : () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState!.value;
                      final request = LoginRequestModel(
                        email: formData['email'],
                        password: formData['password'],
                      );
                      context.read<AuthCubit>().login(request);
                    }
                  },
          ),
          bottomText: 'ليس لديك حساب؟ ',
          bottomActionText: 'إنشاء حساب',
          onBottomActionTap: () {
            context.push(RoutesPaths.signUp);
          },
        );
      },
    );
  }
}
