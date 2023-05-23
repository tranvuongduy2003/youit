import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/screens/group/activity_page.dart';
import 'package:you_it/screens/home/home_page.dart';
import 'package:you_it/screens/message/message_page.dart';
import 'package:you_it/screens/profile/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({this.currentWidget = const ActivityPage()});

  final Widget currentWidget;

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  bool showDrawer = false;
  int selectedIndex = 2;

  void callback(newValue) {
    setState(() {
      showDrawer = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, Widget>;
    //  print(args);
    //  final wid = args['activity'];
    final List<Widget?> widgetOptions = [
      HomePage(),
      MessagePage(),
      widget.currentWidget,
      ProfilePage(),
      Center(
        child: Text('afiwjfw'),
      ),
    ];
    return Scaffold(
      extendBody: selectedIndex == 2 ? true : false,
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: showDrawer
          ? ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                //selectedItemColor: Colors.red,
                selectedItemColor: Colors.red,
                unselectedItemColor: AppColors.startDust,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  if (selectedIndex == 2) {
                    showDrawer = false;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: ImageIcon(
                      AssetImage('assets/images/home.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Chat',
                    icon: ImageIcon(
                      AssetImage('assets/images/message_circle.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Users',
                    icon: ImageIcon(
                      AssetImage('assets/images/users.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Smiley',
                    icon: ImageIcon(
                      AssetImage('assets/images/smiley.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Menu',
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
