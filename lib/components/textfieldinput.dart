import 'package:flutter/material.dart';
import 'package:barcode_scanner/constants.dart';

class TextFieldInput extends StatelessWidget{
  final String text;
  final Color color, textColor;
  final bool obscureText;
  final TextEditingController controller;
  const TextFieldInput({
    Key key,
    this.text = "Password",
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.obscureText = false,
    this.controller
  }): super(key: key);
    @override 
  Widget build(BuildContext context){
    return Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.only(
              right: 25.0, 
              left: 25.0, 
              bottom: 20.0
            ),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: text
            )
            )
    );
  }
}
