import 'package:flutter/material.dart';

void proximaTela(BuildContext context,Widget widget){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget
      )
  );
}
