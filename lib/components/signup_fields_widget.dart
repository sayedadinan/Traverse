import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isObscure;
  final bool showVisibilityToggle;
  final bool isPassword;
  final bool autoValidate;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? toggleVisibility;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isObscure = false,
    this.showVisibilityToggle = false,
    this.isPassword = false,
    this.autoValidate = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.toggleVisibility,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _autoValidate;
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _autoValidate = widget.autoValidate;
    _isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17),
      child: TextFormField(
        autovalidateMode: _autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isObscure,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 244, 241, 241),
          filled: true,
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.showVisibilityToggle && widget.isPassword
              ? IconButton(
                  onPressed: () {
                    if (widget.toggleVisibility != null) {
                      widget.toggleVisibility!();
                    }
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
