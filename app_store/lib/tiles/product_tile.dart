import 'package:app_store/datas/product_data.dart';
import 'package:app_store/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  final String? type;
  final ProductData? dataProduct;

  const ProductTile({Key? key, this.type, this.dataProduct}) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductScreen(productData: widget.dataProduct,)));
        },
        child: Card(
          child: widget.type == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: .8,
                      child: Image.network(
                        widget.dataProduct?.images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            widget.dataProduct?.title ?? 'Campo Vazio',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.dataProduct?.price != null
                                ? 'R\$ ${widget.dataProduct?.price?.toStringAsFixed(2)}'
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
              : Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.network(
                          widget.dataProduct?.images![0],
                          fit: BoxFit.cover,
                          height: 250,
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.dataProduct?.title ?? 'Campo Vazio',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.dataProduct?.price != null
                                    ? 'R\$ ${widget.dataProduct?.price?.toStringAsFixed(2)}'
                                    : 'Campo Vazio',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
        ));
  }
}
