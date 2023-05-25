import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          'Commande passée',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, color: Colors.pink, size: 100),
            SizedBox(height: 16),
            Text(
              'Votre commande a été \n fait avec succès!',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Votre code produit est é:\n $orderId',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
