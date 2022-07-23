import 'package:app_store/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../resources/strings.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: const Text(
          Strings.couponDiscount,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  hintText: Strings.hintInsertYouCoupon),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(Strings.snackbarEmptyCouponDiscount),
                    backgroundColor: Colors.redAccent,
                  ));
                } else {
                  FirebaseFirestore.instance
                      .collection('coupons')
                      .doc(text)
                      .get()
                      .then((docSnap) {
                    if (docSnap.data() != null) {
                      CartModel.of(context).setCupon(text, docSnap.data()!['percent']);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            '${Strings.snackbarInitDiscount} ${docSnap.get('percent')}'
                            '${Strings.snackbarFinalizeDiscount}'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    } else {
                      CartModel.of(context).setCupon(null, 0);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(Strings.snackbarNotExistCouponDiscount),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
