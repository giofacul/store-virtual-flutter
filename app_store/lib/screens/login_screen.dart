import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/home_screen.dart';
import 'package:app_store/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.textPageLogin),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: const Text(
              Strings.createAccount,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                validator: (text) {
                  if (text!.isEmpty || !text.contains("@")) {
                    return Strings.invalidEmail;
                  }
                },
                decoration: const InputDecoration(
                    isDense: true, hintText: Strings.textEmail),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (text) {
                  if (text!.isEmpty || text.length < 4) {
                    return Strings.invalidPassword;
                  }
                },
                decoration: const InputDecoration(
                  hintText: Strings.textPassword,
                  isDense: true,
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      Strings.changePassword,
                      textAlign: TextAlign.right,
                    )),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text(
                    Strings.textPageLogin,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
