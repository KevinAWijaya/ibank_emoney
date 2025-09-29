import 'package:flutter/material.dart';

import 'size.dart';

Widget spaceVerticalSuperSmall = const SizedBox(height: marginSuperSmall);

/// space vertical 12
Widget spaceVerticalSmall = const SizedBox(height: marginSmall);

/// space vertical 20
Widget spaceVerticalMedium = const SizedBox(height: marginMedium);

/// space vertical 24
Widget spaceVerticalLarge = const SizedBox(height: marginLarge);

/// space vertical 32
Widget spaceVerticalSuperLarge = const SizedBox(height: marginExtraLarge);
Widget spaceVerticalCustom(double value) => SizedBox(height: value);

Widget spaceHorizontalSuperSmall = const SizedBox(width: marginSuperSmall);

/// space horizontal 12
Widget spaceHorizontalSmall = const SizedBox(width: marginSmall);

/// space horizontal 20
Widget spaceHorizontalMedium = const SizedBox(width: marginMedium);

/// space horizontal 24
Widget spaceHorizontalLarge = const SizedBox(width: marginLarge);

/// space horizontal 32
Widget spaceHorizontalSuperLarge = const SizedBox(width: marginExtraLarge);
Widget spaceHorizontalCustom(double value) => SizedBox(width: value);

const borderRadiusSmall = BorderRadius.all(Radius.circular(radiusSmall));
const borderRadiusMedium = BorderRadius.all(Radius.circular(radiusMedium));
const borderRadiusLarge = BorderRadius.all(Radius.circular(radiusLarge));
const borderRadiusExtraLarge = BorderRadius.all(Radius.circular(radiusExtraLarge));
const borderRadiusSuperLarge = BorderRadius.all(Radius.circular(radiusSuperLarge));
const borderRadiusMax = BorderRadius.all(Radius.circular(radiusMax));
