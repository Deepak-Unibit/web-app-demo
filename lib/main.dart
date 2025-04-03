import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/utils/theme.util.dart';

import 'api/call.api.dart';
import 'modules/home/view/home.view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  ApiCall.configureDio();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'T20 Prize - Scratch & Win',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemesUtil.light,
      home: HomeView(),
    );
  }
}
