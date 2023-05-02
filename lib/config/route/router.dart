import 'package:flutter/material.dart';
import 'package:you_it/group/group_chat_page.dart';
import 'package:you_it/screens/auth/welcome_page.dart';
import 'package:you_it/screens/auth/login_page.dart';
import 'package:you_it/screens/auth/signup_page.dart';
import 'package:you_it/screens/message/message_detail_page.dart';
import 'package:you_it/screens/message/message_page.dart';
import 'package:you_it/screens/profile/edit_description_page.dart';
import 'package:you_it/screens/profile/edit_info_page.dart';
import 'package:you_it/screens/profile/edit_link_page.dart';
import 'package:you_it/screens/profile/edit_profile_page.dart';
import 'package:you_it/screens/profile/profile_page.dart';

import '../../screens/home/home_page.dart';

import './routes.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcomePage:
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }
      case Routes.homePage:
        {
          return MaterialPageRoute(builder: (_) => const HomePage());
        }
      case Routes.logInPage:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      case Routes.signUpPage:
        {
          return MaterialPageRoute(builder: (_) => const SignUpPage());
        }
      case Routes.messageDetailPage:
        {
          return MaterialPageRoute(builder: (_) => const MessageDetailPage());
        }
      case Routes.messagePage:
        {
          return MaterialPageRoute(builder: (_) => const MessagePage());
        }
      case Routes.editDescriptionPage:
        {
          return MaterialPageRoute(builder: (_) => const EditDescriptionPage());
        }
      case Routes.editInfoPage:
        {
          return MaterialPageRoute(builder: (_) => const EditInfoPage());
        }
      case Routes.editLinkPage:
        {
          return MaterialPageRoute(builder: (_) => const EditLinkPage());
        }
      case Routes.editProfilePage:
        {
          return MaterialPageRoute(builder: (_) => const EditProfilePage());
        }
      case Routes.profilePage:
        {
          return MaterialPageRoute(builder: (_) => const ProfilePage());
        }
      case Routes.groupChatPage:
        {
          return MaterialPageRoute(builder: (_) => const GroupChatPage());
        }
      default:
        {
          MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
        }
    }
  }
}
