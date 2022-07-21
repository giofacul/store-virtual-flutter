import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:app_store/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
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
          body: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
            if (model.isLoading!) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (text) {
                          //TODO MELHORAR A VERIFICAÇÃO DE EMAIL LOGI
                          if (text!.isEmpty || !text.contains("@") || !text.contains('.')) {
                            return Strings.invalidEmail;
                          }
                        },
                        decoration: const InputDecoration(
                            isDense: true, hintText: Strings.textEmail),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passController,
                        validator: (text) {
                          if (text!.isEmpty || text.length < 6) {
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
                            onPressed: () {
                              if (_emailController.text.isEmpty) {
                                _scaffoldKey.currentState!
                                    .showSnackBar(const SnackBar(
                                  content: Text(Strings.emailRecoverPassword),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              }else {
                                model.recoverPass(_emailController.text);
                                _scaffoldKey.currentState!.showSnackBar(SnackBar(
                                  content: const Text(Strings.emailAnalizedPassword),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  duration: const Duration(seconds: 2),
                                ));
                              }
                            },
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
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const HomeScreen()));
                            }
                            model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFailed);
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
                  ));
            }
          })),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFailed() {
    _scaffoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text(Strings.loggedFailedUser),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
