import 'package:app_store/datas/product_data.dart';
import 'package:app_store/tiles/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot? documentSnapshot;

  const CategoryScreen({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(documentSnapshot?.get('title')),
              centerTitle: true,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.grid_on),
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                  )
                ],
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(documentSnapshot?.reference.id)
                  .collection('items')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.65),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              type: 'grid',
                              dataProduct: ProductData.fromDocument(
                                  snapshot.data!.docs[index]));
                        },
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                              type: 'list',
                              dataProduct: ProductData.fromDocument(
                                  snapshot.data!.docs[index]),
                            );
                          })
                    ],
                  );
                }
              },
            )));
  }
}
