import 'package:flutter/material.dart';
import '../pages/home.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Portfolio | Ridwan Fadhilah',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontFamily: 'Roboto')),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),

      // ✅ Use this instead of "home"
      initialRoute: '/',

      // ✅ Declare all routes here
      routes: {'/': (context) => const HomePage()},
    );
  }
}
