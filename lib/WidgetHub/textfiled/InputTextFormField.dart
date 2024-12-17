import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  InputTextFormField(
      {super.key,
      this.width,
      this.height,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.keyboardType,
      this.colorfill,
      this.style,
      required Null Function(dynamic value) onChanged});

  double? width;
  double? height;
  TextEditingController? controller;
  String? hintText;
  Icon? prefixIcon;
  bool? obscureText;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  Color? colorfill;
  TextStyle? style;

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 250,
      height: widget.height ?? 60,
      child: TextFormField(
        controller: widget.controller,
        // onTap: () async {},
        style: TextStyle(fontSize: 22),
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          hintText: widget.hintText,
          hintStyle: widget.style,
          prefixIcon: widget.prefixIcon,
          filled: true,
          fillColor: widget.colorfill,
          suffixIcon: widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
