import 'package:flutter/material.dart';

import '../../utils/validators.dart';

class AuthEmailFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;

  const AuthEmailFieldWidget({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      validator: Validators.email,
    );
  }
}
