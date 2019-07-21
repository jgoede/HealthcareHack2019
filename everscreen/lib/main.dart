//TODO: change passwords of existing to match
//run login pw through encryptionb
//change verification to not be lazy as heck
//beautification- fonts
//comment 


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
              new MaterialPageRoute(builder: (ctxt) => new MetricsM()),//TODO: go to skip
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

          Row(
            children: [
            Text('Email'),
            new Flexible(
              child: new 
              TextField(
                decoration: 
                  InputDecoration(
                  labelText: 'Enter Email')
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
           )
       ]
    )
 );
}
}

class Skip extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    return _SkipState();
  }

}
class _SkipState extends  State<StatefulWidget> {
  String dropdownValue = 'male';
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
                              labelText: 'Enter your age in full years'//TODO: change this to birthdate here and in sign up and in verify
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
                  items: <String>['male','female']
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
    return _SignupState();
  }

}
String encrypt(String pw)
{
  //TODO: write encryption method
  return pw;
}
class _SignupState extends  State<StatefulWidget> { 
  String email='';
  String password ='';
  
  String ageText='';
  String dropdownValue = 'male';
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
                      Text('Email: '),
                      new Flexible( 
                        child: TextField (
                          onChanged: (text){
                            email=text;
                          },
                        )
                      )
                  ]
              ),
              Row(
                  children: [
                      Text('Age: '),
                      new Flexible(
                        child: new TextField(
                          onChanged: (text){
                            ageText = text;
                             
                          },
                        )
                      )
                  ]
              ),
              Row(
                children: [
                  Text('Natal Sex: '),
                  
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['male','female']
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

                            VerifyNewUser(email,password,ageText,dropdownValue,ctxt);                    
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
void VerifyNewUser(String email, String password, String ageText,String sex,BuildContext ctxt )
{
  //convert age to int
   int num=0;
  try 
  {
    num = int.parse(ageText.trim());
  } 
  catch (e) 
  {
    debugPrint(e.toString());
      ReportVerifyError("Unable to parse age to a number", ctxt);
      return;
  }
  //verify email is email and  not taken 
  debugPrint("point b");
  RegExp exp = new RegExp(".+@.+");
  String result = exp.hasMatch(email).toString();
  debugPrint("point c");
  if(result =='true')
  {
    try {
          //TODO: figure out how to do on empty
      
      

    } catch (e) {
      debugPrint("catch" + e.toString());
        //encrypt password
        password = encrypt(password);
        //input into db

        //call launchmetrix 
    }



  }
  else
  {
    ReportVerifyError("Not a valid email address.", ctxt);
  }

}
void ReportVerifyError(String message, BuildContext ctxt)
{
  //TODO: figure this out -> need to tell user message 
}
class MetricsF extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    return _MetricsFState();
  }
}

class _MetricsFState extends State<StatefulWidget>
{
  String bp1="";
  String bp2="";
  String dropDownValue1='';
  String dropDownValue2='';
  @override
Widget build (BuildContext ctxt) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Metrics - Female"),
     ),
      body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
                Container (
                  child: Column(
                          children: [
                        Container (
                            height: 50,
                            child: Text('What is your blood pressure? (systolic/diastolic)')
                        ),
                        Container (
                            height: 30,
                            child: Row(
                                children: [
                                    new Flexible (
                                        child: new TextField()
                                    ),
                                    new Text ('\\'), //TODO: Check escape characters
                                    new Flexible (
                                        child: new TextField()
                                    )
                                ]
                            )
                        )
                    ]
                  ),
                  height: 90
                ),
                Container (
                  child: Column(
                    children: [
                        Container (
                            height: 50,
                            child: Text('Do you have a family history of cervical cancer?')
                        ),
                        Container (
                            height: 30
                            //, dropdown
                            //TODO: add dropdown here for yes/no
                        )
                    ],
                  ),
                  
                  height: 90
                  
                ),
                Container (
                  child: Column(
                    children: [
                        Container (
                            height: 50,
                            child: Text('Do you take high blood pressure medication?')
                        ),
                        Container (
                            height: 30,    
                            //dropdown
                            //TODO: add dropdown here for yes/no
                        )
                    ],
                  ),
                    height: 90
                )
                
            ]
            
        )
    );
  }
}

class MetricsM extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    return _MetricsMState();
  }
}

class _MetricsMState extends State<StatefulWidget>
{

  @override
Widget build (BuildContext ctxt) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Metrics - Male"),
     ),
    body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
                Container (

                    child: Column(
                      children:  [ 
                        Container (
                            height: 50,
                            child: Text('What is your blood pressure? (systolic/diastolic)')
                        ),
                        Container (
                            height: 30,
                            child: Row(
                                children: [
                                    new Flexible (
                                        child: new TextField()
                                    ),
                                    new Text ('\\'), //TODO: Check escape characters
                                    new Flexible (
                                        child: new TextField()
                                    )
                                ]
                            )
                        )
                    ],
                    ),
                    height: 90
                ),
                Container (
                  child: Column(
                    children: [
                        Container (
                            height: 50,
                            child: Text('Do you have a family history of prostate cancer?')
                        ),
                        Container (
                            height: 30
                            //, dropdown
                            //TODO: add dropdown here for yes/no
                        )
                    ],
                  ),
                    height: 90
                ),
                Container ( 
                  child:Column(
                    children: [
                        Container (
                            height: 50,
                            child: Text('Do you have a family history of colorectal cancer?')
                        ),
                        Container (
                            height: 30,    
                            //, dropdown
                            //TODO: add dropdown here for yes/no
                        )
                    ],
                  ),
                    height: 90
                )
                
            ]
            
        )
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
              //TODO Get and display additional recommend screenings from db
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

class Current extends StatelessWidget {
 //TODO: only do if time allows
// Current Schedule Data
// list from DB
var list;
// date nextBloodPressureScreening = August 6, 2019 at 12:00:00 AM UTC-5;
// date nextColonoscopyScreening = July 25, 2019 at 12:00:00 AM UTC-5;
// date nextInfluenzaScreening = July 20, 2021 at 12:00:00 AM UTC-5;
// date nextProstateScreening = July 20, 2020 at 12:00:00 AM UTC-5;
 
 
 @override
 Widget build (BuildContext ctxt) {
   return new Scaffold(
     appBar: new AppBar(
       title: new Text("Currently Scheduled Procedures"),
     ),
     body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Row(
                 children: [
                     Text('Currently Scheduled Appointments: '),
                     Column(
                        children: [
                                // for(var element in list) { //TODO Change to a list.forEach((i)
                                //   child: new Text('$element')
                                // }
                        ]
                     )
                 ]
             )
         ]
     )
   );
 }
}
 
class Schedule extends StatelessWidget {
 //TODO: only do if time allows
// All Possible Procedures Data
// list from DB
var list;
 
 
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
                     Text('Schedule a New Appointment: '),
                     Column(
                        children: [
                                // for (var element in list) { //TODO Change to a list.forEach((i)
                                //     child: new RaisedButton(
                                //         onPressed: () {
                                //             //TODO: What action to take once you push to schedule
                                //             Navigator.push(
                                //                 ctxt,
                                //                 new MaterialPageRoute(builder: (ctxt) => new ()),
                                //             );
                                //         },
                                //         child: Text('$element')
                                //     )
                                // }
                        ]
                     )
                 ]
             )
         ]
     )
   );
 }
}
 
class Faq extends StatelessWidget {
 @override
 //TODO: visuals only
 Widget build (BuildContext ctxt) {
   return new Scaffold(
     appBar: new AppBar(
       title: new Text("Frequently Asked Questions"),
     ),
     body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Row(
                 children: [
                     Column(
                        children: [
                                Text('When should I schedule a blood pressure screening?'),
                                Text('It is recommended men receive a blood pressure screening at least every two years, beginning at age 18.'),
                                Text('Women should also schedule a blood pressure screening, beginning at age 18, at least every two years if blood pressure is normal (lower than 120/80).  Get checked annually if blood pressure is between 120/80 and 139/89.  Discuss with your doctor if you have a blood pressure of 140/90 or higher.')
                        ]
                     )
                 ]
             ),
             Row(
                 children: [
                     Column(
                        children: [
                            Text('When should I schedule a cholesterol screening?'),
                            Text('Men should receive a baseline screening from age 17 to 21.  Routine screenings beginning at age 25 for men with high-risk factors, and age 35 for men with no risk factors.'),
                            Text('For women with increased risk for heart disease, a regular test is needed, starting at age 20.  Ask your doctor how often this is needed.')
                        ]
                     )
                 ]
             ),
             Row(
                 children: [
                     Column(
                        children: [
                            Text('When is an influenza(flu) vaccine recommended?'),
                            Text('An annual influenza vaccine is recommended for both men and women aged 17 and older.')
                        ]
                     )
                ]
            ),
             Row(
                children: [
                     Column(
                        children: [
                            Text('When is a pneumonia vaccine recommended?'),
                            Text('For men and women, two different vaccines are recommended at age 65 and older.')
                        ]
                     )
                ]
            ),
             Row(
                children: [
                     Column(
                        children: [
                            Text('When is a shingles vaccine recommended?'),
                            Text('For men and women, a one-time vaccination is recommended at age 60 and older.')
                        ]
                     )
                ]
            ),
             Row(
                children: [
                     Column(
                        children: [
                            Text('When is a tetenus vaccine recommended?'),
                            Text('For men and women aged 17 and older, a tetenus vaccine is recommended every ten years.')
                        ]
                     )
                ]
            )
        ]
    )
  );
}
}
 
class About extends StatelessWidget {
@override
//TODO: visuals only
Widget build (BuildContext ctxt) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("About Us"),
     ),
    body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
                Text('This app was created on the premise that patients should have greater ease-of-access for information, personalization and consultion about recommended preventative health procedures, such as cancer screenings and vaccines.'),
                Text(''),
                Text('Developers: Michael Chang, Will Wang, Dipak Subramaniam, James Goede, Will Wissmiller'),
                Text('Contact Us: Saint Francis Healthcare: (573)331-3000'),
                Text('Website: www.sfmc.net')
            
            ]
        )
    );
}
}