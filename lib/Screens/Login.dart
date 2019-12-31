import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  bool isEditingUserName = false;
  bool isEditingPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNodeUserName.addListener(() {
      setState(() {
        isEditingUserName = _focusNodeUserName.hasFocus;
      });
    });

    _focusNodePassword.addListener(() {
      setState(() {
        isEditingPassword = _focusNodePassword.hasFocus;
      });

    });
  }

  void doNothing(){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: !(isEditingUserName || isEditingPassword),
              child: Expanded(
                flex: 1,
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Anime ME",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !(isEditingUserName || isEditingPassword),
              child: Expanded(
                flex: 3,
                child: Image(image: AssetImage('assets/naruto_chibi.png')),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[

                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                        child:Text("User Name",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ) ,
                      ),
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        border: new Border.all(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid
                        )
                    ),
                    child: TextField(
                      focusNode: _focusNodeUserName,
                      controller: _userNameController,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child:Text("Password",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ) ,
                        ),
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      border: new Border.all(
                          color: Colors.black,
                          width: 2.0,
                          style: BorderStyle.solid
                      )
                    ),
                    child: TextField(
                      focusNode: _focusNodePassword,
                      controller: _passwordController,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        onPressed: doNothing,
                        color: Colors.deepPurple,
                        child: Text("Login",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 3)),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        onPressed: doNothing,
                        color: Colors.deepPurple,
                        child: Text("Register",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 3)),
                      )
                    ],
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}