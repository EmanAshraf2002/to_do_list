import 'package:flutter/material.dart';

import 'constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      @required this.hintText,
      required this.labelText,
      this.onChanged,
      required this.suffixIcon , String ? title, String ? desc,});

  String? hintText;
  String labelText;
  Function(String)? onChanged;
  Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color:buttonColor ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color:buttonColor ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        hintText: hintText,
        hintStyle:const TextStyle(
          color: Colors.black,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
