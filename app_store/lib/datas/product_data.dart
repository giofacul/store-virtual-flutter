import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String? category;
  String? id;
  String? title;
  String? description;
  double? price;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.reference.id;
    title = documentSnapshot.get('title');
    description = documentSnapshot.get('description');
    price = documentSnapshot.get('price') + 0.0;
    images = documentSnapshot.get('images');
    sizes = documentSnapshot.get('sizes');
  }

  Map<String, dynamic> toResumedMap(){
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }


}
