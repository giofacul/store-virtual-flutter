import 'package:app_store/tiles/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var dividedTiles = ListTile.divideTiles(
                    tiles: snapshot.data!.docs.map((doc) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CategoryTile(
                          documentSnapshot: doc,
                        ),
                      );
                    }).toList(),
                    color: Colors.grey[500])
                .toList();
            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}
