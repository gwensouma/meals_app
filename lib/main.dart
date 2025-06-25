import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screen/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.aBeeZeeTextTheme().copyWith(
    titleLarge: TextStyle(color: Colors.white),
  ),
);

class Test {
  final int a;

  Test(this.a);

  @override
  bool operator ==(covariant Test other) {
    // TODO: implement ==
    return a == other.a;
  }
}

void main() {
  // final Test a1 = Test(1);
  // final Test a2 = Test(1);

  // List<int> a1 = [1, 2, 3];
  // List<int> a2 = [1, 2, 3];

  // print(a1 == a2);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: TabsScreen());
  }
}
