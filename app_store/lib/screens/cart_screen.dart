import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/tiles/cart_tile.dart';
import 'package:app_store/widgets/cart_price.dart';
import 'package:app_store/widgets/discount_card.dart';
import 'package:app_store/widgets/ship_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.myCart),
          centerTitle: true,
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
        body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoggedIn()!) {
              return const Center(child: CircularProgressIndicator());
            } else if (!UserModel.of(context).isLoggedIn()!) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: const Text(
                        Strings.textEntry,
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                    )
                  ],
                ),
              );
            } else if (model.listProducts.isEmpty) {
              return const Center(
                child: Text(
                  Strings.noneProductInCart,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView(
                children: [
                  Column(
                    children: model.listProducts.map((product) {
                      return CartTile(
                        cartProduct: product,
                      );
                    }).toList(),
                  ),
                  const DiscountCard(),
                  const ShipCard(),
                  CartPrice(buy: () async {
                    String? orderId = await model.finishOrder();
                    if (orderId != null) {
                      print('ORDER ID $orderId');
                    }
                  }),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
