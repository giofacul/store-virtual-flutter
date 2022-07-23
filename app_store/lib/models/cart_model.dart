import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  List<CartProduct> listProducts = [];
  bool isLoading = false;

  String? couponCode;
  int? discountPercentage = 0;

  CartModel(this.userModel) {
    if (userModel.isLoggedIn()!) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    listProducts.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.firebaseUser?.user?.uid)
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
        .doc(userModel.firebaseUser?.user?.uid)
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
        .doc(userModel.firebaseUser?.user?.uid)
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
        .doc(userModel.firebaseUser?.user?.uid)
        .collection('cart')
        .doc(cartProduct.cart_id)
        .update(cartProduct.transformToMap());
    notifyListeners();
  }

  void setCupon(String? couponCode, int? discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double? getProductsPrice() {
    double price = 0.0;
    for (CartProduct cartInList in listProducts) {
      final productData = cartInList.productData;
      if (productData != null) {
        price += cartInList.product_quantity! * productData.price!;
      }
      return price;
    }
  }

  double? getDiscount() {
    return getProductsPrice()! * discountPercentage! / 100;
  }

  double? getShipPrice() {
    return 9.99;
  }

  Future<String?> finishOrder() async {
    if (listProducts.isEmpty) {
      return null;
    }
    isLoading = true;
    notifyListeners();

    double? productsPrice = getProductsPrice();
    double? shipPrice = getShipPrice();
    double? discount = getDiscount();

    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection('orders').add({
      'clientId': userModel.firebaseUser?.user?.uid,
      'products': listProducts
          .map((cartProduct) => cartProduct.transformToMap())
          .toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discount,
      'totalPrice': productsPrice! - discount! + shipPrice!,
      'status': 1
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.firebaseUser?.user?.uid)
        .collection('orders')
        .doc(documentReference.id)
        .set({'orderId': documentReference.id});

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.firebaseUser?.user?.uid)
        .collection('cart')
        .get();

    for (DocumentSnapshot docOfProductInCart in querySnapshot.docs) {
      docOfProductInCart.reference.delete();
    }

    listProducts.clear();

    couponCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();

    return documentReference.id;
  }

  void _loadCartItems() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.firebaseUser?.user?.uid)
        .collection('cart')
        .get();

    listProducts =
        querySnapshot.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}
