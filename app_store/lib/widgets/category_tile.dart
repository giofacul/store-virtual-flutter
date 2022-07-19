import 'package:app_store/screens/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot? documentSnapshot;

  const CategoryTile({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          documentSnapshot?.get('icon'),
        ),
      ),
      title: Text(documentSnapshot?.get('title')),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryScreen(
                  documentSnapshot: documentSnapshot,
                )));
      },
    );
  }
}
