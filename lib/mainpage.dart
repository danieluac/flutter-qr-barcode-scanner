import 'package:barcode_scanner/model/login.dart';
import 'package:flutter/material.dart';
import 'components/roundedbutton.dart';
import 'components/textfieldinput.dart';
import 'constants.dart';
import 'scanner.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState(){
    super.initState();    
  }
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
     
    return MaterialApp(
      
       theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage("assets/logo.png"), width: 200.0,),
                        Padding(
                          child: Text(
                            "Barcode and qr scanner",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kPrimaryLightColor,
                              // color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            ),
                          padding: EdgeInsets.symmetric(horizontal:30.0, vertical: 20.0),
                        ),
                        SizedBox(height: 20),
                        TextFieldInput(text: "Email", controller: emailController,),
                        TextFieldInput(text: "Senha", controller: senhaController, obscureText: true),
                        RoundedButton(
                          // text: emailController.text, 
                          text: "ENTRAR", 
                          press: ()async{
                            final DoLogin doLogin = new DoLogin(email: emailController.text, senha: senhaController.text);

                            if(await doLogin.start()){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scanner()));
                            }else {
                              
                            }                             
                            
                          },
                        ),
                        // OutlinedButton(
                        //     onPressed: () =>{  
                        //        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scanner()))
                        //     },
                        //     child: Text('ABRIR LEITOR')), 
                            
                                                
                      ]));
            })));
  }
}