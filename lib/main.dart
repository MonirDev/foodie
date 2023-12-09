import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_theme.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppThemeData.themeData,
    ),
  );
}
