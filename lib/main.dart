// import 'package:check_flutter/register.dart';
// import 'package:check_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop/home.dart';
import 'package:workshop/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  String storeemail = "";
  String storepass = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: new Color(0XFFDC4E41),
        centerTitle: true,
        elevation: 2.2,
        leading: new Icon(Icons.all_inclusive),
        title: Text("Login Here"),

      ),
      body:Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: email,
                    obscureText: true,
                    onChanged: (String email){
                      getEmail(email);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',

                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    onChanged: (String password){
                      getpassword(password);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('Login', textScaleFactor: 1.5,),
                    onPressed: (){
                      checkLogin();

                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 35.0),
                      ),
                      Text("Dont Have an Account?"),
                      SizedBox(
                        width: 10.0,
                      ),

                      RaisedButton(
                        color: Colors.purple,
                        child: Text('Register Now', textScaleFactor: 1.5,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return register();
                          }),);
                        },
                      ),
                    ],
                  ),






                ],
              ),
            ),

          ],
        ),
      ),


    );
  }

  void getEmail(String email) {
    setState(() {
      storeemail = email;
    });
  }

  void getpassword(String password) {
    setState(() {
      storepass = password;
    });
  }

  Future<void> checkLogin() async {

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#@$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(storeemail);
     SharedPreferences localstorage = await SharedPreferences.getInstance();
     String UserEmail = localstorage.getString('userEmail');
     String UserPass = localstorage.getString('userPass');
     print(UserEmail);
     print(UserPass);
      if(!email.text.isEmpty && !password.text.isEmpty) {
      if (emailValid && email.text == UserEmail && password.text == UserPass){
        
      Navigator.push(context, MaterialPageRoute(builder: (context) {
       return mysql();
      }),);
    } else {
      _showMsg("Invalid Email Address");
    }
  } else  {
    _showMsg("Fields Cannot be Empty");
    }
  }

  void _showMsg(String s) {
    final snackBar = SnackBar(
      content: Text(s),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),

    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


}