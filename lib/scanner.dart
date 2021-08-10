import 'package:barcode_scanner/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:xml_rpc/client.dart' as xml_rpc;
import 'package:flutter_session/flutter_session.dart';
import 'package:imagebutton/imagebutton.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  var _scanBarcode = '';
  var _apiResult;

  @override
  void initState() {
    super.initState();
  }
Future <void> validarSemPagar(String barcode)  async{
  dynamic apiResult;
    try {
      var login_id = await xml_rpc.call(
              Uri.parse(apiMainUrl+'common'),
              'login',
              [apiDatabase, "admin","admin" ],
            );

    apiResult = await xml_rpc.call(
              Uri.parse(apiMainUrl+'object'),
              'execute_kw',
              [apiDatabase, login_id,"admin",apiModelToAccess,apiMethodToExecute, [[]],apiMethodParam]
            );
    }catch (e) {
            // barcodeScanRes = "Não foi possível ler o código de barra";
            print(e);
    }

  if (!mounted) return;
    setState((){
      _apiResult = apiResult;
    });     
}
  Future<void> scanQR() async {
    String barcodeScanRes;
    dynamic apiResult;
    dynamic loginId = await FlutterSession().get("token");
    dynamic password = await FlutterSession().get("password");
    print("loginId $loginId");
    print("Pass $password");
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
          
      if (null != barcodeScanRes){
        try {
          // var loginId = await xml_rpc.call(
          //   Uri.parse(apiMainUrl+'common'),
          //   'login',
          //   ["Travel_registration18", "admin","admin" ],
          // );          
          apiResult = await xml_rpc.call(
            Uri.parse(apiMainUrl+'object'),
            'execute_kw',
            [apiDatabase, loginId, password,apiModelToAccess,apiMethodToExecute, [[]],{"name": barcodeScanRes }]
          ); 
        } catch (e) {
          // barcodeScanRes = "Não foi possível ler o código de barra";
          print(e);
        }
      }
    } on PlatformException {
      // barcodeScanRes = 'Não foi possível ler a versão da plataforma...';
    }
    if (!mounted) return;

    setState((){
      _scanBarcode = barcodeScanRes;
      _apiResult = apiResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_apiResult);
    return MaterialApp(
        home: Scaffold(  
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Flex(
                      direction: Axis.vertical,                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[                       
                        if(_apiResult != null && _apiResult['state'] == 'Info')
                            Icon(Icons.info, size: 40, color: Colors.redAccent), 
                        if(_apiResult != null && _apiResult['state'] == 'Info')                       
                          Text(_apiResult['message'], 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 17.0, 
                            color: Colors.red), 
                            textAlign: TextAlign.center
                            ),  

                            if(_apiResult != null && _apiResult['state'] == 'Ok')
                              Icon(Icons.check_circle, size: 40, color: Colors.green), 
                            if(_apiResult != null && _apiResult['state'] == 'Ok')                       
                              Text(_apiResult['message'], 
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 17.0, 
                                color: Colors.green), 
                                textAlign: TextAlign.center
                                ),

                                if(_apiResult != null && _apiResult['state'] == 'Error')
                                  Icon(Icons.error, size: 40, color: Colors.red), 
                                if(_apiResult != null && _apiResult['state'] == 'Error')                       
                                  Text(_apiResult['message'], 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 17.0, 
                                    color: Colors.redAccent), 
                                    textAlign: TextAlign.center
                                    ),



                            Container(
                               margin: EdgeInsets.only(top:20.0),
                               child: Column(
                                 children: [
                                   Padding(
                                         padding: EdgeInsets.all(10),
                                         child:   
                                          ImageButton(
                                              children: <Widget>[],
                                              width: 180,
                                              height: 80,
                                              paddingTop: 5,
                                              pressedImage: Image.asset(
                                                "assets/barcode_icon.JPG",
                                              ),
                                              unpressedImage: Image.asset("assets/barcode_icon.JPG"),
                                              onTap: () {
                                                scanQR();
                                              },
                                          ),                                       
                                       ),
                                       Text("Clique aqui para fazer can", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold))
                               ],),
                            ),                                            
                                               
                      ]));
            })));
  }
}