import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  static const baseUrl = "https://moviesapi.ir/api/v1";
}

class Endpoints {
  static const String movies = '/movies';
  static String movieById(int id) => '/movies/$id';
}

class AppColors {
  static const Color primary = Color(0xFF34344A);
  static const Color lightText = Color(0xFFffffff);
}