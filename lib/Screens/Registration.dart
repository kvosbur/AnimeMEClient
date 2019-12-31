import 'package:anime_me/Controllers/RegistrationController.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class RegistrationPage extends StatefulWidget {

  final RegistrationController controller;
  RegistrationPage({this.controller});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeReenterPassword = FocusNode();

  bool isEditingEmail = false;
  bool isEditingUserName = false;
  bool isEditingPassword = false;
  bool isEditingReenterPassword = false;

  @override
  void initState() {
    super.initState();

    _focusNodeUserName.addListener(() {
      setState(() {
        isEditingUserName = _focusNodeUserName.hasFocus;
      });
    });

    _focusNodeEmail.addListener(() {
      setState(() {
        isEditingEmail = _focusNodeEmail.hasFocus;

      });
    });

    _focusNodePassword.addListener(() {
      setState(() {
        isEditingPassword = _focusNodePassword.hasFocus;
      });
    });

    _focusNodeReenterPassword.addListener(() {
      setState(() {
        isEditingReenterPassword = _focusNodeReenterPassword.hasFocus;
      });
    });

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if(! visible){
          removeAllFocus();
        }
      },
    );
  }

  void doRegister(){
    removeAllFocus();
    widget.controller.submitRegistration(_emailController.text, _userNameController.text,
        _passwordController.text, _reenterPasswordController.text, context,
        <FocusNode>[_focusNodeEmail, _focusNodeUserName, _focusNodePassword,
        _focusNodeReenterPassword]);
  }

  void removeAllFocus(){
    _focusNodeEmail.unfocus();
    _focusNodeUserName.unfocus();
    _focusNodePassword.unfocus();
    _focusNodeReenterPassword.unfocus();
  }

  List<Widget> labeledTextFields(String labelText, TextEditingController controller,
      FocusNode node, bool visible, bool doObscure, TextInputAction action,
      Function formSubmit, TextInputType type){
    return <Widget>[
      Visibility(
        visible: visible,
        child: Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child:Text(labelText,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ) ,
              ),
            )
        ),
      ),
      // text field
      Visibility(
        visible: visible,
        child: Container(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          decoration: BoxDecoration(
              border: new Border.all(
                  color: Colors.black,
                  width: 2.0,
                  style: BorderStyle.solid
              )
          ),
          child: TextField(
            focusNode: node,
            textInputAction: action,
            controller: controller,
            obscureText: doObscure,
            onSubmitted: formSubmit,
            keyboardType: type,
          ),
        ),
      )
    ];
  }

  void _shiftFocus(BuildContext context, FocusNode base, FocusNode next){
    base.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  List<Widget> makePageBody(){
    List<Widget> widgets = List<Widget>();
    widgets.addAll(labeledTextFields("Email", _emailController, _focusNodeEmail,
        !(isEditingPassword || isEditingReenterPassword || isEditingUserName), false,
    TextInputAction.next, (temp) =>_shiftFocus(context, _focusNodeEmail, _focusNodeUserName),
    TextInputType.emailAddress));

    widgets.addAll(labeledTextFields("User Name", _userNameController, _focusNodeUserName,
        !(isEditingReenterPassword || isEditingPassword), false, TextInputAction.next,
        (temp) =>_shiftFocus(context, _focusNodeUserName, _focusNodePassword),
    TextInputType.text));

    widgets.addAll(labeledTextFields("Password", _passwordController,
        _focusNodePassword, ! isEditingEmail, true, TextInputAction.next,
        (temp) =>_shiftFocus(context, _focusNodePassword, _focusNodeReenterPassword),
        TextInputType.text));

    widgets.addAll(labeledTextFields("Re Enter Password", _reenterPasswordController,
          _focusNodeReenterPassword, !(isEditingEmail || isEditingUserName), true,
        TextInputAction.done, (temp) =>_shiftFocus(context, _focusNodeEmail, null),
        TextInputType.text));

    widgets.add(Container(
      height: 20,
    ));
    widgets.add(Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            onPressed: doRegister,
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
    ));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          children: makePageBody(),
        ),
      ),
    );

  }
}