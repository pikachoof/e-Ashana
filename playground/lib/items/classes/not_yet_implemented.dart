import 'package:flutter/material.dart';

void notYetImplemented(BuildContext context) {
  const snackBar = SnackBar(
    content: Text('К сожалению эта функция ещё не поддерживается :('),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
