import 'package:flutter/material.dart';
import 'package:to_do_list/helper/cloud_functions.dart';
import 'package:to_do_list/helper/date_function.dart';
import 'package:to_do_list/widgets/ToDo_model.dart';
import 'package:to_do_list/widgets/constants.dart';
import 'cusstom_text_field.dart';

void viewDialog(BuildContext context ) {
  String? title;
  String? desc;
  int? priorityLevel ;
  String ? status;
  DateTime? dueDate;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a new Task"),
          content: ListView(
            children: [
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                hintText: "enter a title",
                labelText:"title",
                suffixIcon: const Icon(Icons.paste_outlined),
                onChanged: (value) {
                  title = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "enter Description",
                labelText: "desc",
                suffixIcon: const Icon(Icons.line_weight),
                onChanged: (value) {
                  desc = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "enter Task status",
                labelText: "status",
                suffixIcon: const Icon(Icons.add_alert_sharp),
                onChanged: (value) {
                  status = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "enter priority",
                labelText: "priorityLevel",
                suffixIcon: const Icon(Icons.line_weight),
                onChanged: (value) {
                  priorityLevel = int.parse(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async{
                    final pickedDate = await DateFunction().selectDueDate(context);
                      dueDate = pickedDate;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return buttonColor;
                      },
                    ),
                  ),
                  child: const Text("select due date"))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "close",
                style: TextStyle(color: buttonColor),
              ),
            ),
            TextButton(
                onPressed: () {
                  CloudFunctions().addNewTask(task:ToDo(title:title, desc:desc,
                      priorityLevel:priorityLevel ,status: status ,dueDate:dueDate));
                },
                child: const Text(
                  "submit",
                  style: TextStyle(color: buttonColor),
                )),
          ],
        );
      });
}
