import 'package:flutter/material.dart';
import 'package:barcode_scanner/constants.dart';
import 'dart:async';
import 'package:xml_rpc/client.dart' as xml_rpc;
import 'package:flutter_session/flutter_session.dart';

class DoLogin{
  final String email, senha;
  const DoLogin({
    Key key,
    this.email,
    this.senha
  });

  Future start() async {{
     try {
       print(apiMainUrl+'common');
       print(senha);
          var loginId = await xml_rpc.call(
            Uri.parse(apiMainUrl+'common'),
            'login',
            [apiDatabase, email, senha],
          ); 
          print("User id $loginId ");
          if(loginId != false){
            var session = FlutterSession();
            await session.set("token", loginId);
            await session.set("password", senha);
            await session.set("email", email);
            return true;
          }else
          return false;       
          

        } catch (e) {
          print(e);
          return false;
        }
  }
  }
static Future isLogged() async {
  dynamic token = await FlutterSession().get("token");
  if(token != null) return true;
  else return false;
}
}
