import 'package:app_store/datas/product_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData? productData;

  const ProductScreen({Key? key, this.productData}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData? productData;

  _ProductScreenState(this.productData)

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
