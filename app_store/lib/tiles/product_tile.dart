import 'package:app_store/datas/product_data.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String? type;
  final ProductData? dataProduct;

  const ProductTile({Key? key, this.type, this.dataProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
      child: type == 'grid'
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: .8,
                  child: Image.network(
                    dataProduct?.images![0],
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        dataProduct?.title ?? 'Campo Vazio',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        dataProduct?.price != null
                            ? 'R\$ ${dataProduct?.price?.toStringAsFixed(2)}'
                            : 'Campo Vazio',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ))
              ],
            )
          : Row(),
    ));
  }
}
