import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/controllers/theme_controller.dart';

class CustomTextFielddd extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  const CustomTextFielddd({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(1.0),


        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Provider.of<ThemeController>(context, listen: false).darkTheme
              ? Colors.white
              : Colors.black,),

          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            prefixIcon: prefixIcon,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Consistent border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Same as default border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Same as focused border
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.redAccent, width: 1), // Red border on error
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.redAccent, width: 1), // Red when focused with error
            ),
            contentPadding: const EdgeInsets.all(16.0),
            hintStyle: TextStyle(color: Colors.grey.shade400),
            labelStyle: TextStyle(color: Provider.of<ThemeController>(context, listen: false).darkTheme
                ? Colors.white
                : Colors.black,),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid phone number';
            }

            // Check if the phone number starts with the allowed prefixes
            if (!(value.startsWith('05') || value.startsWith('06') || value.startsWith('07'))) {
              return 'Phone number wrong';
            }

            String rawNumber = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
            if (rawNumber.length != 10) {
              return 'Phone number must be exactly 10 digits';
            }
            return null; // Valid phone number
          },
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
