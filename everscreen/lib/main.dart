

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
}
class Landing extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Landing"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new RaisedButton(
            
            onPressed: () {
              Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => new Login()),
              );
            },
            child: Text('Login')
          ),
            
          Row(
            children: [

            new RaisedButton(
            
            onPressed: () {
              Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => new Login()),
            );
          },
          child: Text('Continue without logging in')
          ),
          Text('(Your information will not be saved)')

          ]
          )

        ]
      )
        

    );
  }
}
class Login extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: new Text(""),
    );
  }
}