import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TmdbFormField(
              validator: (String value) {
                if (validateEmail(value)) {
                  return "Please enter a valid email";
                } else if (value.isEmpty) {
                  return "Please enter email";
                } else {
                  return null;
                }
              },
              controller: textController,
              node: f1,
              hintText: "Email",
              isEmail: true,
              isPassword: false,
            ),
            TmdbFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter password";
                } else {
                  return null;
                }
              },
              controller: textController,
              isPassword: true,
              isEmail: false,
              node: f2,
              hintText: "Password",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}

class TmdbFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode node;
  final Function validator;
  final bool isPassword;
  final bool isEmail;

  TmdbFormField({
    this.controller,
    this.hintText,
    this.node,
    this.validator,
    this.isPassword,
    this.isEmail,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusColor: Colors.white,
        hoverColor: Colors.white,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(20.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white30,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white30,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        focusedErrorBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white24,
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye_sharp) : Container(),
      ),
      obscureText: isPassword,
      validator: validator,
      onSaved: (String value) => value.trim(),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      onEditingComplete: node.nextFocus,
    );
  }
}
