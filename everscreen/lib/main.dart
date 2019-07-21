

import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

   
List<String> emails = new List(); 
List<String> passwords = new List(); 

var userMap = new HashMap<String, String>();
void main() {
    // userList = Firestore.instance.collection('users').snapshots().listen((data) =>
    //     log('data: $data'));
    
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
              new MaterialPageRoute(builder: (ctxt) => new Manager()),//TODO change back to skip
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
//TODO: change references of username to email
void Verify(String email,String password, BuildContext ctxt)
{
          //   StreamBuilder<QuerySnapshot> (
          //  stream: Firestore.instance.collection('users')
          //  .snapshots(),
          //  builder: (BuildContext context,
          //  AsyncSnapshot<QuerySnapshot> snapshot) {
          //    if (snapshot.hasError)
          //     return new Text ('Error: ${snapshot.error}');
          //    switch (snapshot.connectionState) { 
          //      case ConnectionState.waiting:
          //        return new Text('Loading...');
          //      default:

 
    
    
}
void CollectUsers(DocumentSnapshot doc)
{
  String email = doc["email"];
  String pw = doc["password"];
  // debugPrint(email+" "+ pw); debug code
  if(!emails.contains(email))
  {
    emails.add(email);
    passwords.add(pw);
  }
}
class Login extends StatelessWidget {
  String email= "";
  String password="";
  @override
  Widget build (BuildContext ctxt) {

      Firestore.instance.collection('users')
        .snapshots().listen((data) =>data.documents.forEach((doc) => CollectUsers(doc)));
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: Column(
        children:
        
        [

                 //Verify(username,password,ctxt);
                 // TODO: Specific D 
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
            onPressed: (){
              // Navigator.push(
              // ctxt,
              // new MaterialPageRoute(builder: (ctxt) => new Manager()),
              //TODO: write verify for this

                TestLogin(email,password,ctxt);
              
            }
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
void TestLogin(String email,String password,BuildContext ctxt)
{
  int testVar = emails.indexOf(email);
  if(testVar==-1)
  {
    //TODO: create error message
  }
  else if(passwords.elementAt(testVar)==password)
  {
      Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new Manager()));
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

class Skip extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SkipState();
  }

}
class _SkipState extends  State<StatefulWidget> {
  String dropdownValue = 'Male';
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select gender and age"),
      ),
      body: Column(
        children: [
              Row(
                  children: [
                      Text('Age: '),
                      new Flexible(
                        child: new TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your age in full years'//TODO: change this to birthdate here and in sign up
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
                                
                                 
                                  launchMetrics(dropdownValue, ctxt);
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
                                  launchMetrics(dropdownValue, ctxt);                          
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

class MetricsF extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MetricsFState();
  }
}

class _MetricsFState extends State<StatefulWidget>
{
  //state variables go here

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp( 
      home: Scaffold(
      appBar: AppBar(
        title: Text('Metric Gathering'),
      ),
        body: Column(
          children:
            [
              Text("This is a placeholder"),
              new Flexible(child: TextField())
              
            ]
          )
        )
      );
  }
}

class MetricsM extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MetricsMState();
  }
}

class _MetricsMState extends State<StatefulWidget>
{
  //state variables go here

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp( 
      home: Scaffold(
      appBar: AppBar(
        title: Text('Metric Gathering'),
      ),
        body: Column(
          children:
            [
              Text("This is a placeholder"),
              new Flexible(child: TextField())
              
            ]
          )
        )
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
// Test Subject Data
var name = 'John Doe';
var race = 'Asian';
int PSA = 5;
int age = 22;
int systolic = 120;
int diastolic = 80;
bool cervicalCancerRisk = true;
bool familyHistoryColorectal = true;
bool heartDiseaseRisk = true;
bool highBloodPressure = true;
bool highRiskBP = true;
bool highRiskCholestrol = true;
bool puberty = true;
// date birthdate = July 20, 1994 at 12:00:00 AM UTC-5;
// date lastBloodPressureScreening = July 6, 2016 at 12:00:00 AM UTC-5;
// date lastColonoscopyScreening = July 20, 2016 at 12:00:00 AM UTC-5;
// date lastInfluenzaScreening = July 20, 2017 at 12:00:00 AM UTC-5;
// date lastProstateScreening = July 20, 1997 at 12:00:00 AM UTC-5;
@override
Widget build (BuildContext ctxt) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Your Information"),
    ),
    body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
            Row(
                children: [
                    Text('Name: '),
                    new Flexible(
                      child: new Text('$name')
                    )
                ]
            ),
            Row(
                children: [
                    Text('Age: '),
                    new Flexible(
                      child: new Text('$age')
                    )
                ]
            ),
             Row(
                children: [
                    Text('Race: '),
                    new Flexible(
                      child: new Text('$race')
                    )
                ]
            ),
             Row(
                children: [
                    Text('Birthdate '),
                    new Flexible(
                      child: new Text('birthdate')
                    )
                ]
            ),
             Row(
                children: [
                    Text('Systolic / Diastolic: '),
                    new Flexible(
                      child: new Text('$systolic' + ' / ' + '$diastolic')
                    )
                ]
            ),
             Row(
                children: [
                    Text('High Blood Pressure: '),
                    new Flexible(
                      child: new Text('$highBloodPressure')
                    )
                ]
            ),
             Row(
                children: [
                    Text('High Blood Pressure Risk: '),
                    new Flexible(
                      child: new Text('$highRiskBP')
                    )
                ]
            ),
             Row(
                children: [
                    Text('High Cholesterol Risk: '),
                    new Flexible(
                      child: new Text('$highRiskCholestrol')
                    )
                ]
            ),
             Row(
                children: [
                    Text('Heart Disease Risk: '),
                    new Flexible(
                      child: new Text('$heartDiseaseRisk')
                    )
                ]
            )
        ]
    )
  );
}
}
void launchMetrics(String sex, BuildContext ctxt)
{
  if(sex == 'male')
  {
    Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new MetricsM()));
  }
  else
  {
    Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new MetricsF()));
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