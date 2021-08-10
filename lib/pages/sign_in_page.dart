import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firabase_chat_app/component/utils/buttons.dart';
import 'package:flutter_firabase_chat_app/constants.dart';
import 'package:flutter_firabase_chat_app/pages/chat_page.dart';
import 'package:flutter_firabase_chat_app/pages/sign_up_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatefulWidget {
  static const id = "signin";

  @override
  _SignInPageState createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
   String email;
   String password;
  bool showprogress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showprogress,
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

                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    password = value;
                  },
                  decoration: textfieldDecoration.copyWith(hintText: "Enter your password", prefixIcon: Icon(Icons.lock)),
                ),

                SizedBox(height: 20,),

                Buttons(color: Colors.blueGrey, title: 'Sign In', onPressed: () async {
                  setState(() {
                    showprogress = true;
                  });
                  try {
                    final existuser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(existuser != null){
                       Navigator.pushNamed(context, ChatPage.id);
                    }
                    setState(() {
                      showprogress = false;
                    });
                  } on Exception catch (e) {
                    print(e);
                  }
                }),

                SizedBox(height: 15,),

                Buttons(color: Colors.blueGrey, title: 'Sign Up', onPressed: (){
                  Navigator.pushNamed(context, SignUpPage.id);
                }),

              ],
            ),
          ),
      ),
        ),
    );
  }
}
