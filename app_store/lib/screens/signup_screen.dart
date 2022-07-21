import 'package:app_store/models/user_model.dart';
import 'package:app_store/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.textPageCreateAccount),
            centerTitle: true,
          ),
          body:
              ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            if (model.isLoading!) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return Strings.invalidName;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            isDense: true, hintText: Strings.textName),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        validator: (text) {
                          if (text!.isEmpty || !text.contains('@')) {
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
                          if (text!.isEmpty || text.length < 4) {
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return Strings.invalidAdress;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            isDense: true, hintText: Strings.textAdress),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> userData = {
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'address': _addressController.text,
                              };
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const HomeScreen()));
                              model.signUp(
                                  userData: userData,
                                  pass: _passController.text,
                                  onSuccess: _onSuccess,
                                  onFailed: _onFailed);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          child: const Text(
                            Strings.textPageCreateAccount,
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
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: const Text(Strings.createSuccessUser),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 2),
    ));
    Future.delayed(const Duration(seconds: 2)).then((_) {
       Navigator.of(context).pop();
     });
  }

  void _onFailed() {
    _scaffoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text(Strings.createFailedUser),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
