import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plotify/app.dart';
import 'package:plotify/core/net/api_service.dart';
import 'package:plotify/features/detail/detail_provider.dart';
import 'package:plotify/features/home/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  final ApiService apiService = ApiService();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider(apiService)),
          ChangeNotifierProvider(create: (context) => DetailProvider(apiService))
        ],
        child: const App(),
      )
  );
}