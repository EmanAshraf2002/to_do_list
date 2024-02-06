import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do_list/helper/cloud_functions.dart';
import 'package:to_do_list/pages/register_page.dart';
import 'package:to_do_list/pages/to_do_list_page.dart';
import 'package:to_do_list/widgets/constants.dart';
import 'package:to_do_list/widgets/custtom_Button.dart';
import 'package:to_do_list/widgets/custtom_text_form_field.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   String? email;

   String? password;

   bool isLoading=false;

   GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        backgroundColor: kBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical:16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                const SizedBox(height: 100,) ,
                 const Text('Login',
                       style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                    ),
                  ),
                 const SizedBox(height: 70,) ,
                 CustomTextFormField(hintText:'Enter your email', labelText:'Email',
                   onChanged: (data){
                      email=data;
                   },
                 ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(hintText:'Enter your password', labelText:'Password',
                    onChanged: (data){
                    password=data;
                    },
                    passObscureText: true ,
                  ),
                  const SizedBox(height: 20,),
                  CustomButton(buttonText: 'Login',
                    onTap: () async{
                    if(formKey.currentState!.validate()){
                       isLoading=true;
                       setState(() {});
                       try{
                         await CloudFunctions().loginUser();
                            Navigator.pushNamed(context,'ToDoPage',arguments: email);
                       }
                       on FirebaseAuthException catch (ex) {
                         if (ex.code == 'user-not-found') {
                           showSnackBar(context,'No user found for that email.');
                         } else if (ex.code == 'wrong-password') {
                           showSnackBar(context,'Wrong password,enter the correct password');
                         }
                       }
                       catch(e){
                         showSnackBar(context,'There was an error');
                       }
                       isLoading=false;
                       setState(() {});
                    }

                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?" ,
                        style: TextStyle(
                            color:buttonColor,
                        ),
                      ),
                      GestureDetector(
                        onTap:() {
                         Navigator.pushNamed(context, 'RegisterPage',);
                        } ,
                        child:const Text('Register',
                          style: TextStyle(
                              color:buttonColor
                          ),
                        ),
                      ),
                    ],

                  ),

                  const SizedBox(height: 70,) ,

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
