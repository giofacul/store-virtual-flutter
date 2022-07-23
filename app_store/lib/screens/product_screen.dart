import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/datas/product_data.dart';
import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/cart_screen.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData? productData;

  const ProductScreen({Key? key, this.productData}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData? productData;
  String? size;

  _ProductScreenState(this.productData);

  int? _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(productData?.title ?? Strings.emptyReturnTitle),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              carouselController: _carouselController,
              items: productData?.images?.map((e) {
                return Image.network(
                  e,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: productData!.images!.asMap().entries.map((entry) {
              return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8,
                    height: 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : primaryColor)
                          .withOpacity(_current! == entry.key ? 0.9 : 0.4),
                    ),
                  ));
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productData?.title ?? Strings.emptyReturnTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${productData?.price?.toStringAsFixed(2) ?? Strings.emptyReturnPrice}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: primaryColor),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  Strings.sizesReturnProductText,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: .5,
                    ),
                    children: productData!.sizes!.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  color: e == size
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                  width: 2)),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(e ?? 'X'),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()!) {
                              //adiciona ao carrinho
                              CartProduct? cartProduct = CartProduct();
                              cartProduct.product_size = size;
                              cartProduct.product_quantity = 1;
                              cartProduct.product_id = productData?.id;
                              cartProduct.product_categoty =
                                  productData?.category;
                              cartProduct.productData = productData;


                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()!
                          ? Strings.buttonAddProductCart
                          : Strings.loggedToBuy,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  Strings.descriptionReturnProduct,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  productData?.description ?? Strings.emptyReturnDescription,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
