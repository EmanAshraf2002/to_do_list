import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ToDo{

 final String? title;
 final String? desc;
 int? priorityLevel ;
 final String? status;
  DateTime? dueDate;


 ToDo({required this.title, required this.desc,@required this.priorityLevel ,
      @required this.status,@required this.dueDate});

  factory ToDo.fromJson(jsonData){
    return ToDo(title: jsonData['title'], desc:jsonData['desc'],
        priorityLevel: jsonData['priorityLevel'],status: jsonData['status'] ,
        dueDate: (jsonData['dueDate'] as Timestamp).toDate());

  }


}