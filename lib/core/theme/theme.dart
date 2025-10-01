import 'package:flutter/material.dart';

import 'color.dart';

ThemeData defaultTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: VColor.neutral6,
    textTheme: Theme.of(context).textTheme.apply(bodyColor: VColor.neutral1, displayColor: VColor.neutral1),
  );
}
