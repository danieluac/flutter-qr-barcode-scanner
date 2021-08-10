import 'package:flutter/material.dart';
import 'package:barcode_scanner/constants.dart';

class RoundedButton extends StatelessWidget{
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }): super(key: key);
    @override 
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
            width: double.infinity,
            padding: EdgeInsets.only(left:25, right:25, top: 5.0, bottom: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: TextButton(
                onPressed: press,
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.login, color: Colors.white,),
                    Padding(
                      child: Text(
                        text, 
                        style: TextStyle(color: textColor)
                      ),
                      padding: EdgeInsets.only(left: 5.0),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],),
                
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color),
                  minimumSize:  MaterialStateProperty.all<Size>(Size(00,50))
                ), 
              ),              
            )
        );
  }
}
