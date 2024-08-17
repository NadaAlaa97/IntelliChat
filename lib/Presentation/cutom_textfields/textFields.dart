import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/My_theme.dart';

class CustomTextFields extends StatefulWidget {
  final IconData icon;
  final IconData? iconPassword;
  bool passwordVisibile;
  TextEditingController controller;
  TextInputType keyboardType;
  String? Function(String?) validator;
  final String hintText;

   CustomTextFields({super.key, required this.icon, required this.hintText,this.iconPassword,this.keyboardType = TextInputType.text,
     required this.controller, required this.validator, this.passwordVisibile = false,
   });

  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      decoration: InputDecoration(
        suffixIcon: widget.iconPassword!= null
            ? IconButton(
          icon: Icon(
            passwordVisible? Icons.visibility : Icons.visibility_off,
            color: MyTheme.bgAppBar,
          ),
          onPressed: () {
            setState(() {
              passwordVisible =!passwordVisible;
            });
          },
        )
            : null,        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(widget.icon,size:35,color: MyTheme.bgAppBar,),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 20
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: MyTheme.bgAppBar,
            width: 2,
          )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: MyTheme.bgAppBar,
              width: 2,
            ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: MyTheme.bgAppBar,
            width: 2,
          ),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: MyTheme.bgAppBar,
            width: 2,
          ),
        ),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: MyTheme.bgAppBar,
            width: 2,
          ),
        ),

      ),
      keyboardType:widget.keyboardType ,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.passwordVisibile &&!passwordVisible,
    );
  }
}
