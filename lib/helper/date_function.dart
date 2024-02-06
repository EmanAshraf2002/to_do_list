import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/constants.dart';

class DateFunction {
  DateTime dueDate = DateTime.now();

  Future<DateTime?> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:buttonColor,
            colorScheme:const ColorScheme.light(primary: buttonColor),
            buttonTheme:const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: Container(
            color: Colors.white,
            child: child,
          ),
        );
      },
    );
    return picked;
  }
}