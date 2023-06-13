import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:you_it/screens/home/home_page.dart';

import './config/route/router.dart' as router;
import './config/themes/app_colors.dart';
import 'config/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: HomePage(),
      initialRoute: Routes.editProfilePage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
