import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FamilySettingsAutoApprovalFieldWidget extends StatelessWidget {
  static final _amountRegex = RegExp(r'^\d{1,7}\.?\d{0,2}$');

  final TextEditingController controller;
  final String currency;

  const FamilySettingsAutoApprovalFieldWidget({
    super.key,
    required this.controller,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(_amountRegex),
      ],
      decoration: InputDecoration(
        labelText: 'Auto-approval limit ($currency)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixText: '$currency ',
      ),
    );
  }
}
