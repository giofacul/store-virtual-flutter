import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/home_screen.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

    return ScopedModel<UserModel>(
        model: UserModel(),
        child:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              //TODO NAME TITLE STORE
              title: Strings.storeName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: colorCustom,
                  primaryColor: const Color.fromARGB(255, 239, 0, 230)),
              home: HomeScreen(),
            ),
          );
        }));
  }
}
