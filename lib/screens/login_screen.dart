import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          'Entrer',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              'Créer un compte',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(24),
              children: <Widget>[
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@')) {
                        return 'E-mail Invalide';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 16),
                TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Mot de pass'),
                    validator: (text) {
                      if (text.isEmpty || text.length < 8) {
                        return 'le mot de pass doit avoir au moins 8 caractere';
                      } else {
                        return null;
                      }
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Insérer votre email pour avoir votre password',
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Confira seu email',
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.pink,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'j' 'ai oublié mon mot de passe',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      'Entrer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'La connexion a échoué',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
