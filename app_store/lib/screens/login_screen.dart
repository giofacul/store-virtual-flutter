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

  //TODO REMOVER DADOS FIXADOS LOGIN
  final _emailController = TextEditingController(text: 'giovannir.i307@gmail.com');

  final _passController = TextEditingController(text: '123456');

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
                child: Text(
                  Strings.textPageCreateAccount.toUpperCase(),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
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
                          //TODO MELHORAR A VERIFICATION DE EMAIL LOGIN
                          if (text!.isEmpty ||
                              !text.contains("@") ||
                              !text.contains('.')) {
                            return Strings.invalidEmail;
                          }
                          return null;
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
                          return null;
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
                              //TODO MELHORAR A RECUPERAÇÃO DE EMAIL VIA LOGIN
                              //TODO CRIAR VALIDAÇÃO APENAS DE EMAIL, SEM CHAMAR FIREBASE
                              if (_emailController.text.isEmpty ||
                                  !_emailController.text.contains('@') ||
                                  !_emailController.text.contains('.')) {
                                _scaffoldKey.currentState!
                                    .showSnackBar(const SnackBar(
                                  content: Text(Strings.emailRecoverPassword),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                //TODO CRIAR ALERTA QUE PODE ESTAR NA CAIXA DE SPAN
                                model.recoverPass(_emailController.text);
                                _scaffoldKey.currentState!
                                    .showSnackBar(SnackBar(
                                  content:
                                      const Text(Strings.emailAnalizedPassword),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
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
                              model.signIn(
                                  email: _emailController.text,
                                  pass: _passController.text,
                                  onSuccess: _onSuccess,
                                  onFail: _onFailed);
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
                  ));
            }
          })),
    );
  }

  void _onSuccess() {
      Navigator.pop(context);
  }

  void _onFailed() {
    _scaffoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text(Strings.loggedFailedUser),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
