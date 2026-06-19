import 'package:flutter/material.dart';

class AuthPasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const AuthPasswordFieldWidget({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
    this.validator,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: onToggle,
        ),
      ),
      validator: validator,
    );
  }
}
