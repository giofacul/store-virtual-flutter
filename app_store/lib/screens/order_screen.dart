import 'package:app_store/resources/strings.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key, this.orderId}) : super(key: key);

  final String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.textPageRequestFinalized),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
              const Text(
                Strings.requestWithSuccess,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text('${Strings.requestCode} $orderId', style: const TextStyle(fontSize: 16),)

              //TODO CRIAR BOTÃO PARA VOLTAR PARA HOME PAGE
            ],
          ),
        ),
      ),
    );
  }
}
