import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  build(context) {
    return Container(
      child: Image.network('https://i.imgur.com/QwhZRyL.png'),
      width: 100,
      height: 100,
    );
  }
}
