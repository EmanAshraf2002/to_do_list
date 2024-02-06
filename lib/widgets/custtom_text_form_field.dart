import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
   CustomTextFormField({super.key , required this.hintText , required this.labelText ,
   this.onChanged, this.passObscureText=false,});

  String? hintText;
  String labelText;
  Function(String)? onChanged;
  bool? passObscureText;

  @override
  Widget build(BuildContext context) {
     return TextFormField(
       style:const TextStyle(color:Colors.black),
       onChanged: onChanged,
       obscureText: passObscureText!,
       validator: (data){
         if(data!.isEmpty){
           return('Field is required');
         }
       },
       decoration:InputDecoration(
         labelText: labelText,
         labelStyle:const TextStyle(
           color: Colors.black ,
           fontSize: 18 ,
         ) ,
         hintText: hintText,
         hintStyle:const TextStyle(
           color: Colors.black ,
           fontSize: 18 ,
         ) ,
         enabledBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
           borderSide:const BorderSide(color: Colors.black),
         ),
         focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
           borderSide:const BorderSide(color: Colors.black),
         ),
       ),









     );
  }





}