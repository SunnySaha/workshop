  
import 'package:workshop/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _Register();
  }
}

class _Register extends State<register>{
  final TextEditingController regemail = new TextEditingController();
  final TextEditingController regpassword = new TextEditingController();
  String storeregemail = "";
  String storeregpass = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:_scaffoldKey ,

      appBar: new AppBar(

        title: Text("Registration page"),
        backgroundColor: new Color(0XFFDC4E41),
        centerTitle: true,
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: regemail,
                    onChanged: (String remail){
                      getRegEmail(remail);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',

                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    obscureText: true,
                    controller: regpassword,
                    onChanged: (String pass){
                      getRegPass(pass);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColorLight,
                      padding: const EdgeInsets.all(0.0),
                    child:Container(

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'Register Now',
                          style: TextStyle(fontSize: 20)
                      ),
                    ),

                    onPressed: (){
                      _register();

                    },
                  ),


                ],
              ),
            ),

          ],
        ),
      ),

    );
  }

  Future<void> _register() async {

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#@$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(storeregemail);

    if(!regpassword.text.isEmpty && !regemail.text.isEmpty) {
     if(emailValid){
       print(regpassword.text);
       print(regemail.text);

       SharedPreferences localstorage = await SharedPreferences.getInstance();
       localstorage.setString("userEmail", regemail.text);
       localstorage.setString("userPass", regpassword.text);
       Navigator.push(context, MaterialPageRoute(builder: (context) {
         return MyApp();
       }),);
     }else{
       _showMsg("Invalid Email Address");
     }
    }else{
      _showMsg("Fields Cannot be Empty");
    }
  }

  void getRegPass(String pass) {
    storeregpass = pass;
    //print(storeregpass);
  }

  void getRegEmail(String remail) {
    storeregemail = remail;
    //print(storeregemail);
  }
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
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