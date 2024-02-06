import 'package:flutter/material.dart';
import 'package:to_do_list/helper/cloud_functions.dart';
import 'package:to_do_list/pages/edit_task_page.dart';


class  Menu extends StatefulWidget{
    Menu({super.key , required this.titleObj, required this.descObj,
     required this.proObj,required this.statusObj,});

  final String titleObj;
  final String descObj;
  final String statusObj;
  final int proObj;


  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {


  @override
  Widget build(BuildContext context) {

    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'option1',
          child: Text('Edit'),
        ),
        const PopupMenuItem<String>(
          value: 'option2',
          child: Text('Delete'),
        ),
      ],
      onSelected: (String value)  {
        // Perform an action when an option is selected
        if (value == 'option1') {
          // Handle option
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return EditTaskScreen(taskTitle: widget.titleObj, taskDesc:widget.descObj,
              taskPro: widget.proObj, taskStatus:widget.statusObj,);
          }));
        } else if (value == 'option2') {
          CloudFunctions().deleteTask(taskTitle:widget.titleObj);
        }
      },
      icon: const Icon(Icons.more_vert ,
                       color: Colors.white,
                      ),

    );

  }
}


