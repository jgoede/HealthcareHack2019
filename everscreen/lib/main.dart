

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
            
          Column(
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
      body: Column(
        children:
        [
          Row(
            children: [
            Text('Username'),
            new Flexible(
              child: new 
              TextField(
                decoration: 
                  InputDecoration(
                  labelText: 'Enter Username')
              )
            )
            ]
          ),
          Row(
            children: [
            Text('Password'),
            new Flexible(
              child: new 
              TextField(
                decoration: 
                  InputDecoration(
                  labelText: 'Enter Password')
              )
            )
            ]
          ),
          RaisedButton(
            child: Text('Login'),
            onPressed: (){},
          ),
          Row(
            children:
            [
              Text('Don\'t have an account?'),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                  ctxt,
                  new MaterialPageRoute(builder: (ctxt) => new Signup()),
                  );
                },
                 child: Container(

                  child: Text(
                    'CLICK HERE',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ]
          )
        ]
        
        
        
        
        
      )
    );
  }
}
class Signup extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign Up"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
              Row(
                  children: [
                      Text('Name: '),
                      new Flexible( 
                        child: new TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your full name'
                          )
                        )
                      )
                  ]
              ),
              Row(
                  children: [
                      Text('Age: '),
                      new Flexible(
                        child: new TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your age in full years'
                          )
                        )
                      )
                  ]
              ),
              Row(
                  children: [
                      Text('Sex: '),
                      new Flexible(child: new TextFormField(
                          decoration: InputDecoration(
                              labelText: ' '
                          )
                        )
                      )
                  ]
              ),
              Row(
                  children: [
                      new RaisedButton(
                          onPressed: () {
                              Navigator.push(
                                  ctxt,
                                  new MaterialPageRoute(builder: (ctxt) => new Metrics()),
                              );
                          },
                          child: Text('Sign Up!')
                      )
                  ]
              )
          ]
      )
    );
  }
}
class Metrics extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
}