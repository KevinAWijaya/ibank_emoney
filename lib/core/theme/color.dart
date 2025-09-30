import 'package:flutter/material.dart';

class VColor {
  // brand color
  static const Color primary1 = Color(0xFF281C9D);
  static const Color primary2 = Color(0xFF5655B9);
  static const Color primary3 = Color(0xFFA8A3D7);
  static const Color primary4 = Color(0xFFF2F1F9);
  static const Color onPrimary = Color(0xFFffffff);

  // background element (card, container)
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF181d17);

  static const Color neutral5 = Color(0xFFE0E0E0);
  static const Color neutral4 = Color(0xFFCACACA);
  static const Color neutral3 = Color(0xFF989898);
  static const Color neutral2 = Color(0xFF898989);
  static const Color neutral1 = Color(0xFF343434);

  // semantic
  static const Color semantic1 = Color(0xFFFF4267);
  static const Color semantic2 = Color(0xFF0890FE);
  static const Color semantic3 = Color(0xFFFFAF2A);
  static const Color semantic4 = Color(0xFF52D5BA);
  static const Color semantic5 = Color(0xFFFB6B18);

  // shadow
  static const Shadow dropShadowCard = Shadow(
    blurRadius: 30,
    offset: Offset(0, 4),
    color: Color.fromARGB(17, 53, 41, 183),
  );
  static const Shadow dropShadowCardSmall = Shadow(
    blurRadius: 30,
    offset: Offset(0, -5),
    color: Color.fromARGB(17, 53, 41, 183),
  );

  // another
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color backgroundCard = Color.fromARGB(255, 238, 238, 238);

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color whiteOpacitiy = Color.fromARGB(20, 255, 255, 255);
  static const Color blackOpacity = Color.fromARGB(20, 0, 0, 0);

  static const Color grey1 = Color(0xFFBFBFBF);
  static const Color grey2 = Color.fromARGB(255, 169, 168, 168);
  static const Color grey3 = Color.fromARGB(255, 86, 86, 86);
  static const Color grey4 = Color.fromARGB(255, 52, 52, 52);

  static const Color grey1Opacity = Color.fromARGB(20, 186, 186, 186);
  static const Color grey2Opacity = Color.fromARGB(20, 122, 122, 122);
  static const Color grey3Opacity = Color.fromARGB(20, 86, 86, 86);
  static const Color grey4Opacity = Color.fromARGB(20, 52, 52, 52);

  static WidgetStateProperty<Color?> overlayColor({Color rippleColor = primary1, Color hoverColor = primary1}) {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return rippleColor.withAlpha(80); // ripple effect
      }
      if (states.contains(WidgetState.hovered)) {
        return hoverColor.withAlpha(40); // hover effect
      }
      return null;
    });
  }
}
