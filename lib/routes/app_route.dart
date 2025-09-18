import 'package:flutter/widgets.dart';
import 'package:plotify/features/splash/splash_page.dart';
import 'package:plotify/routes/main_bottom_nav.dart';

class AppRoute {
  static const String home = "/";
  static const String splash = "/splash";
  static const String detail = "/detail";
  static const String profile = "/profile";
  static const String watchlist = "/watchlist";

  static final Map<String , WidgetBuilder> routes = {
    splash: (ctx) => const SplashPage(),
    home: (ctx) => const MainBottomNav()
  };

}