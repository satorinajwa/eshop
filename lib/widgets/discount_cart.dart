import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Coupon de réduction',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entrez votre coupon'),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection('coupons')
                    .document(text)
                    .get()
                    .then(
                  (docSnap) {
                    if (docSnap.data != null) {
                      CartModel.of(context)
                          .setCoupon(text, docSnap.data['Pourcent']);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.pink,
                        content: Text(
                          'votre remise'
                          '${docSnap.data['Pourcent']}% appliquée',
                        ),
                      ));
                    } else {
                      CartModel.of(context).setCoupon(null, 0);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Ce coupon n'
                            'existe pas, vérifiez votre code '
                            'contactez-nous',
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
