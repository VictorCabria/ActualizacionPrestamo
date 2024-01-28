import 'package:flutter/material.dart';

import 'palette.dart';

class Styles {
  TextStyle tittleRegister = const TextStyle(
    color: Palette.primaryLetter,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle tittle = const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle tittleSub = const TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle errorStyle = const TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
}

Styles styles = Styles();
