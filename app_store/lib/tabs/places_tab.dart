
import 'package:app_store/tiles/place_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  const PlacesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('places').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else {
            return ListView(
              children:snapshot.data!.docs.map((e) => PlaceTile(documentSnapshot: e,)).toList(),
            );
          }
        });
  }
}
