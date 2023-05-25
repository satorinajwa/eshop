import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';
import '../tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn) {
      var uid = UserModel.of(context).firebaseUser.uid;
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection('users')
            .document(uid)
            .collection('orders')
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.documents
                  .map((doc) => OrderTile(doc.documentID))
                  .toList()
                  .reversed
                  .toList(),
            );
          }
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list, size: 80, color: Colors.pink),
            SizedBox(height: 16),
            Text(
              'Connectez-vous pour suivre !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text(
                'Entrer',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            )
          ],
        ),
      );
    }
  }
}
