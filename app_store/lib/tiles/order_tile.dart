import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String? orderId;

  const OrderTile({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido ${snapshot.data?.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(_buildProductsText(snapshot.data!) ??
                      'Dados não retornados')
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String? _buildProductsText(DocumentSnapshot documentSnapshot) {
    String text = 'Descrição:\n';
    for (LinkedHashMap productOfList in documentSnapshot['products'] ?? '') {
      text +=
          '${productOfList['product_quantity']} x ${productOfList['product']['title']}'
          ' (R\$ ${productOfList['product']['price'].toStringAsFixed(2)})\n';
      text += 'Total R\$ ${documentSnapshot['totalPrice'].toStringAsFixed(2)}';
      return text;
    }
  }
}
