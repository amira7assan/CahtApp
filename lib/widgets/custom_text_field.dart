import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({Key? key, this.obscureText=false,this.hintText,this.onchange, this.controller}) : super(key: key) ;
String? hintText;
bool? obscureText;
Function(String)?onchange;
   final TextEditingController? controller; // Add controller here

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data){
        if(data!.isEmpty){
          return 'field is empty';
        }
      }
      ,
      controller: controller,
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
          )
    ),);

  }
}
