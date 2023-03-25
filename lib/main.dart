import 'package:flutter/material.dart';

import './config/route/routes.dart';
import './config/route/router.dart' as router;
import './config/themes/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      initialRoute: Routes.logInPage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
