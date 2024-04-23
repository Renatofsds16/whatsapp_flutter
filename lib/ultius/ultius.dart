import 'package:flutter/material.dart';

void proximaTela(BuildContext context,Widget widget){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => widget
      )
  );
}
