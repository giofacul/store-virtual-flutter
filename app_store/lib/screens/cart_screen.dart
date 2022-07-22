import 'package:app_store/models/cart_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.myCart),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.listProducts.length;
                return Text(
                  '$p ${p == 1 ? Strings.oneItemsReturnCart : Strings.quantityItemsReturnCart}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
