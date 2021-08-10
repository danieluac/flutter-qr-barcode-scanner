
import 'package:flutter/material.dart';
import 'package:barcode_scanner/constants.dart';

class ApiResultState extends StatelessWidget{
  final apiResult;
  const ApiResultState({
    Key key,
    this.apiResult,
  }): super(key: key);
    @override 
  Widget build(BuildContext context){
    print(apiResult);
 Size size = MediaQuery.of(context).size;
    if( apiResult['state'] == "Ok")
        return Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.only(
              right: 25.0, 
              left: 25.0, 
              bottom: 20.0
            ),
            child: Column(
              children: [
                Icon(Icons.check, size: 50, color: Colors.green),
                if(null != apiResult)
                 Text(apiResult['message'], 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 30.0, 
                            color: Colors.green), 
                            textAlign: TextAlign.center
                            ),  
              ],
            )
        );
    else  return Container();
  }
}
