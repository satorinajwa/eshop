import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/cart_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            var price = model.getProductPrice();
            var discount = model.getDiscount();
            var ship = model.getShipPrice();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Récapitulatif des achats',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                          fontFamily: 'Merriweather',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                    Text(
                      'R\$ ${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Remise',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'R\$ ${discount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Livraison',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'R\$ ${ship.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                          fontFamily: 'Merriweather',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                    Text(
                      'R\$ ${(price + ship - discount).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text(
                    'Comparer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: buy,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
