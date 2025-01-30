import 'package:adivina_el_numero/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'src/ui/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adivina el número',
      home: HomeWidget(),
      theme: AppTheme().theme(),
    );
  }
}
