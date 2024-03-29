import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/cart_screen.dart';
import 'package:app_store/tabs/home_tab.dart';
import 'package:app_store/tabs/orders_tab.dart';
import 'package:app_store/tabs/places_tab.dart';
import 'package:app_store/tabs/product_tab.dart';
import 'package:app_store/widgets/cart_button.dart';
import 'package:app_store/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>
      (builder: (_, __, userModel) {
      if (userModel != null) {
          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              //TODO SET PAGES IN ORDER TO DRAWER NAVIGATION
              Scaffold(
                drawer: CustomDrawer(
                  pageController: _pageController,
                ),
                body: const HomeTab(),
                floatingActionButton: const CartButton(),
              ),

              Scaffold(
                appBar: AppBar(
                  title: const Text(Strings.productsDrawer),
                  centerTitle: true,
                ),
                drawer: CustomDrawer(
                  pageController: _pageController,
                ),
                body: const ProductsTab(),
                floatingActionButton: const CartButton(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text(Strings.storesDrawer),
                  centerTitle: true,
                ),
                drawer: CustomDrawer(
                  pageController: _pageController,
                ),
                body: const PlacesTab(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text(Strings.myRequestsDrawer),
                  centerTitle: true,
                ),
                drawer: CustomDrawer(
                  pageController: _pageController,
                ),
                body: const OrdersTab(),
              ),
              if(userModel.adminEnabled)
                ...[
                  Scaffold(
                    appBar: AppBar(
                      title: const Text(Strings.usersDrawer),
                      centerTitle: true,
                    ),
                    drawer: CustomDrawer(
                      pageController: _pageController,
                    ),
                    body:  Container(color: Colors.blueAccent,),
                  ),
                  Scaffold(
                    appBar: AppBar(
                      title: const Text(Strings.usersRequestsDrawer),
                      centerTitle: true,
                    ),
                    drawer: CustomDrawer(
                      pageController: _pageController,
                    ),
                  ),
                ]
            ],
          );
      } else {
        return Container();
      }
    });
  }
}
