import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController? pageController;

  CustomDrawer({Key? key, this.pageController}) : super(key: key);

  @override
  //TODO COLOR DRAWER
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 169, 241, 161),
              Color.fromARGB(255, 0, 208, 255),
            ], begin: Alignment.bottomCenter, end: Alignment.topRight),
          ),
        );
    //TODO CREATE DRAWER
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                        top: 32,
                        left: 0,
                        child: Text(
                          Strings.storeName,
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Strings.welcomeUser} ${!model.isLoggedIn()! ? '' : model.userData['name']}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!model.isLoggedIn()!) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    } else {
                                      pageController?.jumpToPage(0);
                                      model.signOut();
                                    }
                                  },
                                  child: Text(
                                    !model.isLoggedIn()!
                                        ? Strings.loggedOrSignUpDrawer
                                        : Strings.signOutDrawer,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                  ],
                ),
              ),
              const Divider(thickness: 2),

              //TODO INSERT DRAWERS
              DrawerTile(
                iconData: Icons.home,
                text: Strings.initDrawer,
                pageController: pageController,
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                text: Strings.productsDrawer,
                pageController: pageController,
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                text: Strings.storesDrawer,
                pageController: pageController,
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                text: Strings.myRequestsDrawer,
                pageController: pageController,
                page: 3,
              ),
              ScopedModelDescendant<UserModel>(
                builder: (_, __, userModel) {
                  if (userModel != null) {
                    if (userModel.adminEnabled) {
                      return Column(
                        children: [
                          const Divider(thickness: 2),
                          DrawerTile(
                            iconData: Icons.settings,
                            text: Strings.usersDrawer,
                            pageController: pageController,
                            page: 4,
                          ),
                          DrawerTile(
                            iconData: Icons.settings,
                            text: Strings.usersRequestsDrawer,
                            pageController: pageController,
                            page: 5,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
