import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class RegisterNameRowWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const RegisterNameRowWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: firstNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'First name',
              prefixIcon: Icon(Icons.person_outlined),
            ),
            validator: (value) => Validators.required(value, 'First name'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: lastNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              hintText: 'Last name',
            ),
            validator: (value) => Validators.required(value, 'Last name'),
          ),
        ),
      ],
    );
  }
}
