//TODO: change passwords of existing to match
//run login pw through encryption
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
import 'package:crypt/crypt.dart';

List<String> emails = new List(); 
List<String> passwords = new List();
String currentEmail = ""; 
List<String> screeningNames = new List();
List<String> minAges = new List();
List<String> maxAges = new List();



var userMap = new HashMap<String, String>();
void main() {
    // userList = Firestore.instance.collection('users').snapshots().listen((data) =>
    //     log('data: $data'));
    Firestore.instance.collection('screenings').snapshots().listen((data) =>
        data.documents.forEach((doc) => CollectScreenings(doc)));
  runApp(MyApp());   
}

void CollectScreenings(DocumentSnapshot doc) {
  screeningNames.add(doc["name"]);
  minAges.add(doc["minAge"]);
  maxAges.add(doc["maxAge"]);
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Center(
             child: 
             new RaisedButton(
            
            onPressed: () {
              Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => new Login()),
              );
            },
            child: Text('Login')
          )
           ),
            
          Column(
            children: [

             new RaisedButton(
            
            onPressed: () {
              Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => new Skip()),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        
        [

          Row(
            children: [
            Padding(padding: EdgeInsets.all(8), child: 
            Text('Email')),
            Flexible(
              child: new 
              TextField(
                onChanged: (text) {
                  email = text;
                },
                decoration: 
                  InputDecoration(
                  labelText: 'Enter Email')
              )
            )
            ]
          ),
          Row(
            children: [
            Padding(padding: EdgeInsets.all(8), child: 
            Text('Password')
            ,),
            new Flexible(
              child: new 
              TextField(
                onChanged: (text) {
                  password = text;
                },
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
              Padding(padding: EdgeInsets.all(8), child: 
              Text('Don\'t have an account?')
              ,),
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

void _showDialog(BuildContext ctxt, String errorMsg) {
  showDialog(
    context: ctxt,
    builder: (ctxt) {
      return AlertDialog(
        title: new Text("Error"),
        content: new Text(errorMsg),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(ctxt).pop();
            },
          ),
        ],
      );
    },
  );
}

void TestLogin(String email,String password,BuildContext ctxt)
{
  int testVar = emails.indexOf(email.trim());
  if(testVar==-1)
  {
    _showDialog(ctxt, 'Email was not found. Please try again.');
  }
  else if(passwords.elementAt(testVar)==encrypt(password))
  {
    currentEmail = email;
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
                          child: Text('Continue to Metrics')
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
  var sh = new Crypt.sha256(pw,salt: "slajhdflkjawqer");
  return sh.toString();
}
class _SignupState extends  State<StatefulWidget> { 
  String email='';
  String password ='';
  
  String birthDateText='';
  String sex = 'Male';
  DateTime birthDate = DateTime.now();
  TextEditingController birthDateController = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
        
        var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        String monthName = monthNames[birthDate.month - 1];
        birthDateController.text = "${monthName} ${birthDate.day.toString()}, ${birthDate.year.toString()}";
      });
  }

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
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Email: ')
                      ,),
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
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Password: ')
                      ,),
                      new Flexible( 
                        child: TextField (
                          onChanged: (text){
                            password=text;
                          },
                        )
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Birthdate: ')
                      ,),
                      new Flexible(
                        child: new TextField(
                          controller: birthDateController,
                          onTap: () => _selectDate(ctxt)
                        )
                      )
                  ]
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(8), child: 
                  Text('Natal Sex: ')
                  ,),
                  
                DropdownButton<String>(
                  value: sex,
                  onChanged: (String newValue) {
                    setState(() {
                      sex = newValue;
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
                        Padding(padding: EdgeInsets.all(8), child: 
                        new RaisedButton(
                               onPressed: () {

                            VerifyNewUser(email,password,birthDate,sex,ctxt);                    
                               },
                          child: Text('Sign Up!')
                        )
                        ,)
                      ]
              )
          ]
      )
    );
  }
}
void VerifyNewUser(String email, String password, DateTime birthDate,String sex,BuildContext ctxt )
{
  //verify email is email and not taken 
  debugPrint("point b");
  RegExp exp = new RegExp(".+@.+");
  String result = exp.hasMatch(email).toString();
  debugPrint("point c");
  if(result =='true')
  {
    try {
          
       TestEmail(birthDate, password,ctxt,sex,email.trim());
      

    } catch (e) {
      _showDialog(ctxt, e.toString()+". Please try again.");
      return;
    }

  }
  else
  {
    _showDialog(ctxt, "Not a valid email address. Please try again");
  }

}
void TestEmail(DateTime birthDate, String pw, BuildContext ctxt,String sex, String email){
  // for (DocumentSnapshot doc in data.documents) 
  // {
  //   //debugPrint(doc.toString()+ " "+ doc["email"]);
  // if(doc["email"].trim()==email)
  //  {
     
  //     _showDialog(ctxt, "Email address already in use. Please try again");
  //     return;
  //  };
  // }
  

  debugPrint("got past check");
        //encrypt password
        pw = encrypt(pw);
        //TODO: input into db
        currentEmail = email;
Firestore.instance.collection('users').document(email).setData({
  "email": email,
  "password": pw,
  "birthDate": birthDate,
  "sex": sex
});


        //call launchmetrix 
        launchMetrics(sex, ctxt);

        
}
class MetricsF extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    return _MetricsFState();
  }
}

class _MetricsFState extends State<StatefulWidget>
{
  int sys = 0;
  int dia = 0;
  bool cervicalCancer = false;
  bool bpMedication = false;
  String bp1="";
  String bp2="";
  String dropDownValue1='no';
  String dropDownValue2='no';
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
                                        child: new TextField(
                                          onChanged:(text){bp1 = text;},
                                        )
                                    ),
                                    new Text ('\\'), 
                                    new Flexible (
                                        child: new TextField(
                                          onChanged: (text){bp2 = text;},
                                        )
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
                            height: 30,
                            child: 
                            DropdownButton<String>(
                              value: dropDownValue1,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropDownValue1 = newValue;
                                  if (newValue == "no") {
                                    cervicalCancer = false;
                                  } else {
                                    cervicalCancer = true;
                                  }
                                  });
                                },
                                items: <String>['yes','no']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),  
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
                            child: DropdownButton<String>(
                              value: dropDownValue2,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropDownValue2 = newValue;
                                  if (newValue == "no") {
                                    bpMedication = false;
                                  } else {
                                    bpMedication = true;
                                  }
                                  });
                                },
                                items: <String>['yes','no']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                    ],
                  ),
                    height: 90
                ),
                Row(
                      children: [
                        new RaisedButton(
                               onPressed: () {
                               try 
                                {
                                  sys = int.parse(bp1.trim());
                                } 
                                catch (e) 
                                {
                                  debugPrint(e.toString());
                                    _showDialog(ctxt, "Unable to parse BP to a number");
                                    return;
                                
                                }    
                                try 
                                {
                                  dia = int.parse(bp2.trim());
                                } 
                                catch (e) 
                                {
                                  debugPrint(e.toString());
                                    _showDialog(ctxt, "Unable to parse BP to a number");
                                    return;
                                }
                                sendFemaleMetrics(sys, dia, cervicalCancer, bpMedication);
                                Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new Info()));              
                               },
                              child: Text('Submit')
                        )
                      ]
                 )
            ]
            
        )
    );
  }
}

void sendMaleMetrics(int sys, int dia, bool colorectalCancer, bool prostateCancer) {
  Firestore.instance.collection('users').document(currentEmail).setData({
    "systolic": sys,
    "diastolic": dia,
    "prostateCancerFamilyHistory": prostateCancer,
    "colorectalCancerFamilyHistory": colorectalCancer
  }, merge: true);
} 

void sendFemaleMetrics(int sys, int dia, bool cervicalCancer, bool bpMedication) {
  Firestore.instance.collection('users').document(currentEmail).setData({
    "systolic": sys,
    "diastolic": dia,
    "cervicalCancerFamilyHistory": cervicalCancer,
    "takesBPMedication": bpMedication
  }, merge: true);
}

class MetricsM extends StatefulWidget {
    
  @override
  State<StatefulWidget> createState() {
    return _MetricsMState();
  }
}

class _MetricsMState extends State<StatefulWidget>
{ 
//TODO: code submit (same for metricsFstate)
  int sys = 0;
  int dia = 0;
  String bp1="";
  String bp2="";
  String dropDownValue1='no';
  String dropDownValue2='no';
  bool prostateCancer = false;
  bool colorectalCancer = false;
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
                                        child: new TextField(onChanged:(text){bp1 = text;},)
                                    ),
                                    new Text ('\\'),
                                    new Flexible (
                                        child: new TextField(onChanged:(text){bp2 = text;},)
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
                            height: 30,
                            child: DropdownButton<String>(
                              value: dropDownValue1,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropDownValue1 = newValue;
                                  });
                                  if (newValue == "yes") {
                                    prostateCancer = true;
                                  } else {
                                    prostateCancer = false;
                                  }
                                },
                                items: <String>['yes','no']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

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
                            child: DropdownButton<String>(
                              value: dropDownValue2,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropDownValue2 = newValue;
                                  });
                                  if (newValue == "yes") {
                                    colorectalCancer = true;
                                  } else {
                                    colorectalCancer = false;
                                  }
                                },
                                items: <String>['yes','no']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                    ],
                  ),
                    height: 90
                ),
                Row(
                      children: [
                        new RaisedButton(
                               onPressed: () {
                                try 
                                {
                                  sys = int.parse(bp1.trim());
                                } 
                                catch (e) 
                                {
                                  debugPrint(e.toString());
                                    _showDialog(ctxt, "Unable to parse BP to a number");
                                    return;
                                
                                }    
                                try 
                                {
                                  dia = int.parse(bp2.trim());
                                } 
                                catch (e) 
                                {
                                  debugPrint(e.toString());
                                    _showDialog(ctxt, "Unable to parse BP to a number");
                                    return;
                                }
                                sendMaleMetrics(sys, dia, colorectalCancer, prostateCancer);
                                Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new Info()));                     
                               },
                              child: Text('Submit')
                        )
                      ]
                 )                
            ]
            
        )
    );
}
}

class Info extends StatelessWidget {
  // Test Subject Data
  String name = 'John Doe';
  String race = 'Asian';
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
      body: ListView(
          
        children: [
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Name: ')
                      ,),
                      new Flexible(
                        child: new Text('$name')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                        Text('Age: ')
                      ,),
                      new Flexible(
                        child: new Text('$age')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Race: ')
                      ,),
                      new Flexible(
                        child: new Text('$race')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Birthdate ')
                      ,),
                      new Flexible(
                        child: new Text('birthdate')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('Systolic / Diastolic: ')
                      ,),
                      new Flexible(
                        child: new Text('$systolic' + ' / ' + '$diastolic')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('High Blood Pressure: ')
                      ),
                      new Flexible(
                        child: new Text('$highBloodPressure')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      
                      Text('High Blood Pressure Risk: ')
                      ,),
                      new Flexible(
                        child: new Text('$highRiskBP')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      Text('High Cholesterol Risk: ')
                      ,),
                      new Flexible(
                        child: new Text('$highRiskCholestrol')
                      )
                  ]
              ),
              Row(
                  children: [
                      Padding(padding: EdgeInsets.all(8), child: 
                      
                      Text('Heart Disease Risk: ')),
                      new Flexible(
                        child: new Text('$heartDiseaseRisk')
                      )
                  ]
              ),
              //TODO Get and display additional recommend screenings from db
              Row(children: <Widget>[
                
                Padding(padding: EdgeInsets.all(8), child:
                Container(width: 100, child: Text('Colonoscopy Screening Advised'),)
                ,),
                new Flexible(child: Padding(padding: EdgeInsets.all(8), child: 
                Text('Given your family history of colorectal cancer, you may need to be screened despite being younger than 50 years old. Time frames for screening, as well as risks and benefits, vary for different screening methods. Talk to your healthcare provider about which test is best for you. ')
                ,),)

              ],
              ),
              Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(8), child: 
                Container(width: 100, child: Text('Prostate Screening Advised'),)
                ,),
                new Flexible(child: Padding(padding: EdgeInsets.all(8), child: 
                Text('Given that you are between 40-45 years old, you may need to take an early prostate-specific antige1 (PSA) test to detect future risk of prostate cancer and enlarged prostate symptoms. Discuss your risk factors for prostate cancer with your healthcare provider.')
                ,),)

              ],
              ),
          ]
      )
    );
  }
}

void launchMetrics(String sex, BuildContext ctxt)
{
  if(sex == 'Male')
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