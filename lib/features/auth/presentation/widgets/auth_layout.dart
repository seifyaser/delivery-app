import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthLayout extends StatelessWidget {
  final GlobalKey<FormBuilderState>? formKey;
  final IconData topIcon;
  final double iconSize;
  final String title;
  final List<Widget> fields;
  final Widget actionButton;
  final String bottomText;
  final String bottomActionText;
  final VoidCallback onBottomActionTap;

  const AuthLayout({
    super.key,
    this.formKey,
    required this.topIcon,
    this.iconSize = 100,
    required this.title,
    required this.fields,
    required this.actionButton,
    required this.bottomText,
    required this.bottomActionText,
    required this.onBottomActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4F4),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    topIcon,
                    size: iconSize,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  ...fields,
                  const SizedBox(height: 40),
                  actionButton,
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bottomText,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: onBottomActionTap,
                        child: Text(
                          bottomActionText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
