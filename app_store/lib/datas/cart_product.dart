import 'package:app_store/datas/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String? cart_id;

  String? product_categoty;
  String?  product_id;

  int? product_quantity;
  String? product_size;
  ProductData? productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot? documentSnapshot){
    cart_id = documentSnapshot?.id;
    product_categoty = documentSnapshot?.get('product_categoty');
    product_id = documentSnapshot?.get('product_id');
    product_quantity = documentSnapshot?.get('product_quantity');
    product_size = documentSnapshot?.get('product_size');

  }

  //ADICIONANDO PRODUTO NO BANCO DE DADOS
  Map<String, dynamic> transformToMap(){
    return {
      'product_categoty': product_categoty,
      'product_id': product_id,
      'product_quantity': product_quantity,
      'product_size': product_size,
      'product': productData?.toResumedMap(),
    };
  }


}