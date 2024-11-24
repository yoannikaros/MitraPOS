import 'package:flutter/material.dart';
import 'package:mitrapos/component/navigation.dart';
import 'package:mitrapos/view/cashier/cashierPage.dart';
import 'package:mitrapos/view/demo/meja_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => MainPage(),
      },
    );
  }
}
