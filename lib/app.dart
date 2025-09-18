import 'package:flutter/material.dart';
import 'package:plotify/core/theme.dart';
import 'package:plotify/routes/app_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plotify",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoute.splash,
      routes: AppRoute.routes,
    );
  }
}