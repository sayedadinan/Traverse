import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hinttext;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const Inputfield({
    this.controller,
    Key? key,
    required this.label,
    required this.hinttext,
    this.keyboardType,
    this.validator, // Use the constructor parameter directly
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 244, 241, 241),
        filled: true,
        labelText: label,
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
