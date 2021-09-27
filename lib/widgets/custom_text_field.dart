import 'package:flutter/material.dart';
import 'package:login_registration_screen/constants/color_helper.dart';
class CustomTextField extends StatelessWidget {
 final String hintText;
 final bool obscureText;
 final TextEditingController controller;
 final TextInputType textInputType;
 CustomTextField(
     { required  this.textInputType, required this.controller, required this.hintText, required this.obscureText, });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 65,
      color:  signUpTextFieldColor,

      child: TextField(
        controller: controller,
        obscureText:obscureText ,
        keyboardType: textInputType,
        decoration: InputDecoration(
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText:hintText ,

      ),),
    );
  }
}
