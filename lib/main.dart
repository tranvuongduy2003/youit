import 'package:flutter/material.dart';

import './config/route/routes.dart';
import './config/route/router.dart' as router;
import './config/themes/app_colors.dart';
import 'config/themes/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          titleTextStyle: AppTextStyles.sectionTitle,
          iconTheme: IconThemeData(color: AppColors.black),
          centerTitle: true,
          toolbarTextStyle: AppTextStyles.appbarButtonTitle,
        ),
      ),
      initialRoute: Routes.groupInformationPage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
