import 'package:flutter/material.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_page.dart';
import 'package:you_it/screens/general/genaral_page.dart';
import 'package:you_it/screens/group/activity_page.dart';
import 'package:you_it/screens/auth/welcome_page.dart';
import 'package:you_it/screens/auth/login_page.dart';
import 'package:you_it/screens/auth/signup_page.dart';
import 'package:you_it/screens/group/posting_page.dart';
import 'package:you_it/screens/group/group_information.dart';
import 'package:you_it/screens/group/member_list_page.dart';
import 'package:you_it/screens/group/upload_file_page.dart';
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
      case Routes.groupInformationPage:
        {
          return MaterialPageRoute(
              builder: (_) => const GroupInformationPage());
        }

      case Routes.memberListPage:
        {
          return MaterialPageRoute(builder: (_) => const MemberListPage());
        }
      case Routes.activityPage:
        {
          return MaterialPageRoute(builder: (_) => const ActivityPage());
        }
      case Routes.postingPage:
        {
          return MaterialPageRoute(builder: (_) => const PostingPage());
        }
      case Routes.uploadFilePage:
        {
          return MaterialPageRoute(builder: (_) => const UploadFilePage());
        }
      case Routes.generalPage:
        {
          return MaterialPageRoute(builder: (_) => const GeneralPage());
        }
      case Routes.bottomNavBarPage:
        {
          return MaterialPageRoute(builder: (_) => const BottomNavBarPage());
        }

      default:
        {
          return MaterialPageRoute(
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
