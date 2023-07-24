import 'package:flutter/material.dart';

Color secondColor = const Color.fromARGB(249, 216, 28, 3);
Color secondColorgradient = const Color.fromARGB(250, 204, 159, 136);
Color primaryColor = const Color.fromARGB(250, 219, 60, 39);
Color backgroundColor = const Color.fromARGB(255, 245, 200, 180);
Color backgroundColor2 = const Color.fromARGB(255, 255, 230, 200);
Color grey = const Color.fromRGBO(99, 75, 72, 0.973);
Color positive = const Color.fromARGB(255, 60, 219, 116);
Color negative = const Color.fromARGB(255, 39, 79, 219);
Color neutral = const Color.fromARGB(255, 220, 220, 220);
Color tipo = const Color.fromARGB(255, 45, 45, 45);
Color tipo2 = const Color.fromARGB(255, 118, 128, 153);
Color tipo3 = const Color.fromARGB(255, 212, 213, 231);
Color backstat = const Color.fromARGB(255, 17, 33, 56);
Color backstat2 = const Color.fromARGB(255, 21, 42, 60);
Color backstat3 = const Color.fromARGB(255, 12, 24, 38);
Color linecolor = const Color.fromARGB(255, 131, 82, 239);
Color complementaryColor = const Color.fromARGB(255, 39, 219, 60);

Color themeColor1 = const Color.fromARGB(255, 64, 75, 92);
Color themeColor2 = const Color.fromARGB(255, 78, 92, 111);
Color themeColor3 = const Color.fromARGB(255, 92, 109, 130);
Color themeColor4 = const Color.fromARGB(255, 106, 126, 149);

// Gradient pour le nouveau groupe de couleurs
Gradient newThemeGradient = LinearGradient(
  colors: [themeColor1, themeColor2, themeColor3, themeColor4],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
Gradient primaryGradient = LinearGradient(
  colors: [secondColor, secondColorgradient],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
Gradient weekStatGradient = LinearGradient(
  colors: [backstat, backstat2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
