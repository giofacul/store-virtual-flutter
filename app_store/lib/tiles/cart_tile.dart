import 'package:app_store/datas/product_data.dart';
import 'package:app_store/models/cart_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datas/cart_product.dart';

class CartTile extends StatefulWidget {
  final CartProduct? cartProduct;

  const CartTile({Key? key, this.cartProduct}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    Widget? _buildContent() {
      return Row(
        children: [
          SizedBox(
            width: 120,
            child: Image.network(
              widget.cartProduct?.productData?.images![0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Text(
                    widget.cartProduct?.productData?.title ?? Strings.emptyReturnTitle,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    '${Strings.sizesReturnProductText}: ${widget.cartProduct
                        ?.product_size}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${widget.cartProduct?.productData?.price?.toStringAsFixed(
                        2)}',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: widget.cartProduct!.product_quantity! > 1 ? () {
                          CartModel.of(context).decrementProduct(widget.cartProduct);
                        } : null,
                        icon: Icon(Icons.remove,
                            color: Theme
                                .of(context)
                                .primaryColor),
                      ),
                      Text(widget.cartProduct?.product_quantity.toString() ?? ''),
                      IconButton(
                          onPressed: () {
                            CartModel.of(context).incrementProduct(widget.cartProduct!);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme
                                .of(context)
                                .primaryColor,
                          )),
                      TextButton(
                          onPressed: () {
                            CartModel.of(context).removeCartItem(widget.cartProduct!);
                          },
                          child: const Text(
                            Strings.buttonRemoveItem,
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
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: widget.cartProduct?.productData == null
            ? FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('products')
                .doc(widget.cartProduct?.product_categoty)
                .collection('items')
                .doc(widget.cartProduct?.product_id)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                widget.cartProduct?.productData =
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
