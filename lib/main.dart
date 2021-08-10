import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firabase_chat_app/pages/chat_page.dart';
import 'package:flutter_firabase_chat_app/pages/sign_in_page.dart';
import 'package:flutter_firabase_chat_app/pages/sign_up_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignInPage.id,
      routes: {
        SignInPage.id : (context) => SignInPage(),
        SignUpPage.id : (context) => SignUpPage(),
        ChatPage.id : (context) => ChatPage(),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
    );
  }
}
