import 'package:flutter/material.dart';

class kTextFormField extends StatelessWidget {
  final String hint;
  final String? errorMessage;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isPasswordType;
  final IconData? icon;
  final Widget? passwordIcon;

  final validator;

  const kTextFormField({
    super.key,
    this.passwordIcon,
    required this.hint,
    required this.textEditingController,
    required this.keyboardType,
    required this.obscureText,
    this.icon,
    this.validator,
    required this.isPasswordType,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: textEditingController,
      obscureText: obscureText,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        errorText: errorMessage,
        suffixIcon: isPasswordType ? passwordIcon : null,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
