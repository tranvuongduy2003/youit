import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:you_it/screens/auth/welcome_page.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_with_group_list_page.dart';
import 'package:you_it/service/database_service.dart';

import './config/route/router.dart' as router;
import './config/themes/app_colors.dart';
import 'firebase_options.dart';

class TestClass {
  static void callback(String id, int status, int progress) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FlutterDownloader.registerCallback(TestClass.callback);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (state == AppLifecycleState.resumed) {
      DatabaseService(uid: userId).setUserOnlineStatus(true);
    } else {
      DatabaseService(uid: userId).setUserOnlineStatus(false);
    }
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return BottomNavBarWithGroupListPage();
          }
          return WelcomePage();
        },
      ),
      // home: WelcomePage(),
      //initialRoute: Routes.welcomePage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
