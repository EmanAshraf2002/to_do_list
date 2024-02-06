import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/ToDo_model.dart';

class CloudFunctions{
  String? email;

  String? password;

  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  FirebaseAuth U=FirebaseAuth.instance;
  Future<void> addNewTask({ required ToDo task})async{
    return tasks.add({

      'title':task.title,
      'desc':task.desc ,
      'createdAt':DateTime.now(),
      'priorityLevel':task.priorityLevel,
      "status":task.status,
      'dueDate':task.dueDate,

    })
        .then((value) => print("tak added"))
        .catchError((error)=>print("failed to add task ${error}"));
  }


  Future<void> deleteTask({required String taskTitle}) async{

     try{
       final querySnapshot =await
       tasks.where('title',isEqualTo: taskTitle).get();
       if (querySnapshot.docs.isNotEmpty){
         final taskId=querySnapshot.docs.first.id;
         await tasks.doc(taskId).delete();
       }
       else{
         print('Task not found');
       }

     }
     catch(e){
       print('Error deleting task: $e');
     }
  }

  Future<void> editTask({required ToDo task}) async {

      await tasks
          .where('title', isEqualTo: task.title) // Query based on the title
          .get()
          .then((querySnapshot) {
        if (querySnapshot.size == 1) {
          // Assuming there's only one task with the given title
          var documentSnapshot = querySnapshot.docs[0];
          var documentId = documentSnapshot.id; // Retrieve the document ID

          print("Updating task with ID: $documentId");
          return tasks.doc(documentId).update({
            "title": task.title,
            "desc": task.desc,
            "priorityLevel": task.priorityLevel,
            "status":task.status,


          }).then((value) {
            print("Task updated successfully");
          }).catchError((error) {
            print("Failed to update Task: $error");
          });
        } else {
          print("Task not found or multiple tasks found");
        }
      }).catchError((error) {
        print("Failed to query for Task: $error");
      });
    }

  Future<void> loginUser() async {
    if (email != null && password != null) {
      var auth = FirebaseAuth.instance;
      UserCredential user =
      await auth.signInWithEmailAndPassword(email: email!, password: password!);
    }
  }
Future<void> registerUser() async{
  if (email != null && password != null) {
    var auth = FirebaseAuth.instance;
    UserCredential user =
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}

  String getEmailName(String email) {
    final parts = email.split('@');
    final name =parts[0];
    final capitalized = name.substring(0, 1).toUpperCase() + name.substring(1);
    return capitalized;
  }


}
void showSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),),);
}
