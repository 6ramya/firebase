import 'package:firebase/widgets/login_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.teal[200],
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Image.network(
                          'https://firebase.google.com/downloads/brand-guidelines/PNG/logo-vertical.png',
                          height: 150)),
                  SizedBox(height: 20),
                  Text('Firebase',
                      style: TextStyle(color: Colors.amber[300], fontSize: 40)),
                  Text(
                    'CRUD',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 40),
                  )
                ],
              )),
              FutureBuilder(
                future: _initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return LoginForm(focusNode: _focusNode);
                  }
                  return CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
