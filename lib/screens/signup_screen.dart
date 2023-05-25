import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

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
          'Créer un compte',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nom et prénom',
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'nom incorrect';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@')) {
                      return 'E-mail invalide';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Mot de passe'),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return 'Le mot de pass doit contenir au mois 6 caractere';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: 'Adresse'),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Adresse invalide';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      'Créer un compte',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var userData = <String, dynamic>{
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text,
                        };
                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Vous avez créé votre compte avec succès!',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.pink,
        duration: Duration(seconds: 3),
      ),
    );
    Future.delayed(Duration(seconds: 3)).then(
      (_) => Navigator.of(context).pop(),
    );
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Échec de la création de l' 'utilisateur',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
