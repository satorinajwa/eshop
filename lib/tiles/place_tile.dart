import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Image.network(
              snapshot.data['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  snapshot.data['title'],
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                Text(
                  snapshot.data['address'],
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 8.0,
              width: double.maxFinite,
              child: Divider(
                height: 4,
                color: Colors.pink,
                indent: 50,
                endIndent: 50,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  'Voir sur la carte',
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                onPressed: () {
                  launch(
                      'https://www.google.com/maps/search/?api=1&query=${snapshot.data['lat']},'
                      '${snapshot.data['long']}');
                },
              ),
              ElevatedButton(
                child: Text(
                  'Se connecter',
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                onPressed: () {
                  launch('tel: ${snapshot.data['phone']}');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
