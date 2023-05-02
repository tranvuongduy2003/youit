import 'package:flutter/material.dart';
import 'package:you_it/chat/group_chat.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: AppBarTheme(
            // backgroundColor: AppColors.white,
            // elevation: 0,
            // centerTitle: true,
            ),
      ),
      home: GroupChat(),
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
