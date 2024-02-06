import 'package:flutter/material.dart';
import 'package:to_do_list/helper/cloud_functions.dart';
import 'package:to_do_list/widgets/ToDo_model.dart';
import 'package:to_do_list/widgets/constants.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskTitle;
  final String taskDesc;
  final String taskStatus;
  final int taskPro;



   EditTaskScreen({Key? key, required this.taskTitle, required this.taskDesc,
    required this.taskPro, required this.taskStatus ,}) : super(key: key);

  @override
  EditTaskScreenState createState() => EditTaskScreenState();
}

class EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  TextEditingController statusEditingController = TextEditingController();
  TextEditingController proEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();
    // Set the initial value of the text field to the task title
    titleEditingController.text = widget.taskTitle;
    descEditingController.text = widget.taskDesc;
    statusEditingController.text=widget.taskStatus;
    proEditingController.text = widget.taskPro.toString();


  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descEditingController.dispose();
    statusEditingController.dispose();
    proEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:buttonColor,
        title:const Text('Edit Task'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller:titleEditingController,
              decoration:const InputDecoration(
                labelText: 'Edit Title',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller:descEditingController,
              decoration:const InputDecoration(
                labelText: 'Edit Description',
              ),
            ),
            TextField(
              controller:statusEditingController,
              decoration:const InputDecoration(
                labelText: 'Edit status',
              ),
            ),

            TextField(
              controller:proEditingController,
              decoration:const InputDecoration(
                labelText: 'Edit priorityLevel',
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String updatedTaskTitle = titleEditingController.text;
                    String updatedTaskDesc=descEditingController.text;
                    String updatedTaskStatus=statusEditingController.text;
                    int updatedTaskPro = int.tryParse(proEditingController.text) ?? 0;
                    CloudFunctions().editTask(task: ToDo(title: updatedTaskTitle,
                      desc: updatedTaskDesc,
                      priorityLevel: updatedTaskPro ,
                      status: updatedTaskStatus));

                    Navigator.pop(context); // Close the EditTaskScreen
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return buttonColor;
                      },
                    ),
                  ),
                  child:const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return buttonColor;
                      },
                    ),
                  ),
                  child: const Text(
                    "cancel",),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}