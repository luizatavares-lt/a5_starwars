import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LogonPage extends StatefulWidget {
  final String title;
  static const String route = '/logon';

  const LogonPage({Key key, this.title = "Logon"}) : super(key: key);

  @override
  _LogonPageState createState() => _LogonPageState();
}

class _LogonPageState extends State<LogonPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white, cursorColor: Colors.white),
        home: Scaffold(
            appBar: AppBar(
              title: Text('STAR WARS',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.deepPurple,
            ),
            body: Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/home2.jpg"),
                      fit: BoxFit.cover)
                  ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(20.0),
                        child: Center(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                return null;
                              },
                        ))),
                    Container(
                        margin: EdgeInsets.all(20.0),
                        child: Center(
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.white)),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return null;
                          },
                        ))),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _signInWithEmailAndPassword();
                          }
                        },
                        child: const Text('Enviar'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _success == null
                            ? ''
                            : (_success
                                ? 'Successfully signed in ' + _userEmail
                                : 'Sign in failed'),
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    FirebaseUser user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
    } catch (error) {
      var msg = error.toString();
      if (error.code == "ERROR_WRONG_PASSWORD") {
        msg = "Senha Inválida!";
      }

      showDialog(
        builder: (context) {
          return AlertDialog(
            title: new Text("Erro"),
            content: new Text(msg),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        context: context,
      );
    }

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}
