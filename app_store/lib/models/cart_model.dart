import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel? userModel;
  List<CartProduct> listProducts = [];
  bool? isLoading = false;

  CartModel(this.userModel) {
    if (userModel!.isLoggedIn()!) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    listProducts.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.firebaseUser?.user?.uid)
        .collection('cart')
        .add(cartProduct.transformToMap())
        .then((doc) {
      cartProduct.cart_id = doc.id;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.firebaseUser?.user?.uid)
        .collection('cart')
        .doc(cartProduct.cart_id)
        .delete();

    listProducts.remove(cartProduct);
    notifyListeners();
  }

  void decrementProduct(CartProduct? cartProduct) {
    if (cartProduct?.product_quantity != null) {
      cartProduct?.product_quantity = cartProduct.product_quantity! - 1;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.firebaseUser?.user?.uid)
        .collection('cart')
        .doc(cartProduct?.cart_id)
        .update(cartProduct!.transformToMap());
    notifyListeners();
  }

  void incrementProduct(CartProduct cartProduct) {
    if (cartProduct.product_quantity != null) {
      cartProduct.product_quantity = cartProduct.product_quantity! + 1;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.firebaseUser?.user?.uid)
        .collection('cart')
        .doc(cartProduct.cart_id)
        .update(cartProduct.transformToMap());
    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.firebaseUser?.user?.uid)
        .collection('cart')
        .get();

    listProducts =
        querySnapshot.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
  }
}
