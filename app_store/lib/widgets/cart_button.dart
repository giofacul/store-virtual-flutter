import 'package:app_store/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const CartScreen()));
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    );
  }
}
