import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showSnackBar(
      (SnackBar(content: Text(content))),
    );
}
