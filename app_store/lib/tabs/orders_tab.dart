import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/tiles/order_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (UserModel.of(context).isLoading! &&
          UserModel.of(context).isLoggedIn()!) {
        return const Center(child: CircularProgressIndicator());
      } else if (!UserModel.of(context).isLoggedIn()!) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.view_list,
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                Strings.loggedToAccompany,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                child: const Text(
                  Strings.loggedToContinue,
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ],
          ),
        );
      } else {
        String? uid = UserModel.of(context).firebaseUser?.user?.uid;
        return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('orders')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => OrderTile(orderId: doc.id))
                      .toList()
                      .reversed
                      .toList(),
                );
              }
            });
      }
    });
  }
}
