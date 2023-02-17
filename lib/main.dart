import 'package:amazon_clone/pages/AuthPages/login.dart';
import 'package:amazon_clone/pages/AuthPages/register.dart';
import 'package:amazon_clone/pages/home/home_page.dart';
import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/services/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBzrChyEUDC0r1GWy6JShUcDOX4_w4egsE",
            authDomain: "clone-6427e.firebaseapp.com",
            projectId: "clone-6427e",
            storageBucket: "clone-6427e.appspot.com",
            messagingSenderId: "765071982056",
            appId: "1:765071982056:web:43d326a8c8536f9aed785d"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          }),
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
