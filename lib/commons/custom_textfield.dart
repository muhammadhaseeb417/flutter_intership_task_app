import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final double? height;
  final String hintText;
  final bool isPassword;
  final RegExp? validatorRegExp;
  final void Function(String?) onSaved;
  final String inputType;

  const CustomTextfield({
    super.key,
    this.height = 20,
    required this.hintText,
    this.isPassword = false,
    this.validatorRegExp,
    required this.onSaved,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: TextFormField(
        onSaved: onSaved,
        validator: (value) {
          if (value != null && validatorRegExp!.hasMatch(value)) {
            return null;
          }
          return "Please enter a valid ${inputType.toLowerCase()}";
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 30,
                  ),
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(1000), // Rounded borders based on height
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: height!, // Adjust content alignment based on height
            horizontal: 16,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          height: 1, // Maintain text height
        ),
      ),
    );
  }
}
