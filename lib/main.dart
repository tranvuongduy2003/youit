import 'package:firebase_core/firebase_core.dart';
import 'package:you_it/screens/home/home_page.dart';
import 'config/route/routes.dart';
import 'firebase_options.dart';

import 'package:you_it/screens/auth/login_page.dart';
import 'package:you_it/helper/helper_function.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_with_group_list_page.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';

import './config/route/router.dart' as router;
import './config/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserLogged = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isUserLogged = value;
        });
      }
    });
  }

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
      initialRoute: Routes.welcomePage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
