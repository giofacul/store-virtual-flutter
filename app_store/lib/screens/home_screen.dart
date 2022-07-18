import 'package:app_store/tabs/home_tab.dart';
import 'package:app_store/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        //TODO SET PAGES IN ORDER TO DRAWER NAVIGATION
        Scaffold(
            body: const HomeTab(),
            drawer: CustomDrawer(
              pageController: _pageController,
            )),
      ],
    );
  }
}
