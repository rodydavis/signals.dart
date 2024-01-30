import 'dart:developer';

import 'package:flutter/material.dart';

void warn(String warning, {BuildContext? context}) {
  log(warning);
  if (context != null) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(warning)),
    );
  }
}
