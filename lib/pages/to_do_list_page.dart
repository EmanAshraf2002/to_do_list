import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/helper/cloud_functions.dart';
import 'package:to_do_list/widgets/ToDo_model.dart';
import 'package:to_do_list/widgets/constants.dart';
import 'package:to_do_list/widgets/dialog_widget.dart';
import 'package:to_do_list/widgets/menu.dart';


class ToDoPage extends StatefulWidget {
  ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    final String? email = arguments as String;
    final String? name = CloudFunctions().getEmailName(email!);

    return StreamBuilder<QuerySnapshot>(
        stream: tasks.orderBy('priorityLevel').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ToDo> taskList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              taskList.add(ToDo.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: kBackground,
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        'Hi $name!',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Let's Manage Your Day ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: buttonColor,
                              child: ListTile(
                                leading: Text(taskList[index].title!,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                title: Text(taskList[index].desc!,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                subtitle:Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(taskList[index].status! ,style:
                                    const TextStyle(color: Colors.white),),
                                    Text(DateFormat('dd/MM/yyyy').format(taskList[index].dueDate!) ,style:
                                    const TextStyle(color: Colors.white),),
                                  ],
                                ),
                                trailing: Menu(
                                  titleObj: taskList[index].title!,
                                  descObj: taskList[index].desc!,
                                  proObj: taskList[index].priorityLevel!,
                                  statusObj: taskList[index].status!,

                                ),

                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: FloatingActionButton(
                        onPressed: () {
                          viewDialog(context);
                        },
                        backgroundColor: buttonColor,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } //end if
          else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }


}

