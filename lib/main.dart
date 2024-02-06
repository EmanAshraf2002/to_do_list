import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/login_page.dart';
import 'package:to_do_list/pages/register_page.dart';
import 'package:to_do_list/pages/to_do_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        ' HomePage': (context)=>const HomePage(),
        'RegisterPage' : (context) => RegisterPage() ,
        'ToDoPage' : (context)=>ToDoPage(),
        'LoginPage':(context)=>LoginPage(),
      },
      initialRoute: ' HomePage',
      );

  }
}
