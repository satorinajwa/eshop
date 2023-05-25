import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('Products').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents
                      .map((doc) => CategoryTile(doc))
                      .toList(),
                  color: Colors.grey[800])
              .toList();
          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
