import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text(
          'Calculer Frais',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Cette fonctionnalité sera bientôt disponible...',
              ),
              initialValue: '',
              onFieldSubmitted: (text) {},
            ),
          )
        ],
      ),
    );
  }
}
