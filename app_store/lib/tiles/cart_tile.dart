import 'package:app_store/datas/product_data.dart';
import 'package:app_store/resources/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datas/cart_product.dart';

class CartTile extends StatelessWidget {
  final CartProduct? cartProduct;

  const CartTile({Key? key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _buildContent() {
      return Row(
        children: [
          Container(
            width: 120,
            child: Image.network(
              cartProduct?.productData?.images![0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              Text(
                cartProduct?.productData?.title ?? Strings.emptyReturnTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                '${Strings.sizesReturnProductText}: ${cartProduct?.product_size}',
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'R\$ ${cartProduct?.productData?.price?.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove),
                  ),
                  Text(cartProduct?.product_quantity.toString() ?? ''),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        Strings.textRemove,
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              )
            ]),
          ))
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: cartProduct?.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('products')
                    .doc(cartProduct?.product_categoty)
                    .collection('items')
                    .doc(cartProduct?.product_id)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct?.productData =
                        ProductData.fromDocument(snapshot.data!);
                    return _buildContent()!;
                  } else {
                    return Container(
                      height: 70,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                })
            : _buildContent());
  }
}
