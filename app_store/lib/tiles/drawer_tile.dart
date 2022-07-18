import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  final PageController? pageController;
  final int? page;

  DrawerTile(
      {Key? key, this.iconData, this.text, this.pageController, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    //TODO CREATE ITEMS REPLICATED DRAWER

    var actualPage = pageController?.page?.round() == page;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController!.jumpToPage(page!);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                iconData ?? Icons.adb_outlined,
                size: 32,
                color: actualPage
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text ?? '',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        actualPage ? FontWeight.bold : FontWeight.normal,
                    color: actualPage
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
