import 'package:app_store/resources/strings.dart';
import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: const Text(
          Strings.zipCodeCalculate,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        leading: const Icon(
          Icons.location_on,
        ),
        trailing: const Icon(Icons.keyboard_arrow_down_rounded),
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    hintText: Strings.insertYoutZipCode),
                initialValue: '',
                onFieldSubmitted: (text) {},
              ))
        ],
      ),
    );
  }
}
