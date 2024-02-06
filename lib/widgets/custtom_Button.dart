import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.buttonText, this.onTap});

  String buttonText;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:buttonColor,
        ),
        width: double.infinity,
        height: 60,
        child: Center(child: Text(buttonText,
        style:const TextStyle(color: Colors.white,fontSize: 20),
        ),
        ),
      ),
    );
  }
}
