import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firabase_chat_app/component/utils/buttons.dart';
import 'package:flutter_firabase_chat_app/constants.dart';
import 'package:flutter_firabase_chat_app/pages/sign_in_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpPage extends StatefulWidget {
  static const id = "signup";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showProgress ,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlutterLogo(
                  size: 200,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    email = value;
                  },
                  decoration: textfieldDecoration.copyWith(hintText: "Enter your Email", prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(height: 20,),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    password = value;
                  },
                  decoration: textfieldDecoration.copyWith(hintText: "Enter your password", prefixIcon: Icon(Icons.lock)),
                ),

                SizedBox(height: 15,),

                Buttons(color: Colors.blueGrey, title: 'Register', onPressed: ()async{
                  setState(() {
                    showProgress = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newuser != null){
                       Navigator.pushNamed(context, SignInPage.id);
                    }
                    setState(() {
                      showProgress = false;
                    });

                  } on Exception catch (e) {
                    print(e);
                  }


                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
