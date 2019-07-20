

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

final databaseReference = FirebaseDatabase.instance.reference();
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
class Manager extends StatelessWidget {
@override
Widget build (BuildContext ctxt) {
 return new Scaffold(
   appBar: new AppBar(
     title: new Text("EverScreen Manager"),
   ),
   body: Column(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
           Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new Current()),
                           );
                       },
                       child: Text('Current Schedule')
                   )
               ]
           ),
            Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new Info()),
                           );
                       },
                       child: Text('View Current Info')
                   )
               ]
           ),
           Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new Schedule()),
                           );
                       },
                       child: Text('Schedule Procedures')
                   )
               ]
           ),
           Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new Faq()),
                           );
                       },
                       child: Text('FAQ')
                   )
               ]
           ),
           Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new About()),
                           );
                       },
                       child: Text('About')
                   )
               ]
           ),
            Row(
               children: [
                   new RaisedButton(
                       onPressed: () {
                           Navigator.push(
                               ctxt,
                               new MaterialPageRoute(builder: (ctxt) => new Help()),
                           );
                       },
                       child: Text('Help')
                   )
               ]
           )
       ]
    )
 );
}
}


class Signup extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignupState();
  }

}
class _SignupState extends  State<StatefulWidget> {
  String dropdownValue = 'Male';
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
                  
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Male','Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
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
class Current extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 
class Info extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 
class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 
class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 
class About extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Landing(),
    );
  }
} 