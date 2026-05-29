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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          topIcon: Icons.person_add_alt_1,
          iconSize: 80,
          title: 'إنشاء حساب جديد',
          fields: [
            AuthTextField(
              name: 'name',
              hintText: 'الاسم بالكامل',
              icon: Icons.person,
              validator: FormBuilderValidators.required(errorText: 'هذا الحقل مطلوب'),
            ),
            const SizedBox(height: 16),
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
              name: 'phone',
              hintText: 'رقم الهاتف',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'هذا الحقل مطلوب'),
                FormBuilderValidators.numeric(errorText: 'أرقام فقط'),
              ]),
            ),
            const SizedBox(height: 16),
            AuthTextField(
              name: 'password',
              hintText: 'كلمة المرور',
              icon: Icons.lock,
              isPassword: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'هذا الحقل مطلوب'),
                FormBuilderValidators.minLength(6, errorText: 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'),
              ]),
            ),
          ],
          actionButton: AuthButton(
            text: isLoading ? 'جاري التحميل...' : 'إنشاء حساب',
            onTap: isLoading
                ? () {}
                : () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState!.value;
                      final request = RegisterRequestModel(
                        name: formData['name'],
                        email: formData['email'],
                        phone: formData['phone'],
                        password: formData['password'],
                      );
                      context.read<AuthCubit>().register(request);
                    }
                  },
          ),
          bottomText: 'لديك حساب بالفعل؟ ',
          bottomActionText: 'تسجيل الدخول',
          onBottomActionTap: () {
            context.pop();
          },
        );
      },
    );
  }
}
