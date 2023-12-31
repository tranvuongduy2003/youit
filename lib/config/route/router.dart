import 'package:flutter/material.dart';
import 'package:you_it/screens/auth/fill_info_page.dart';
import 'package:you_it/screens/auth/forgot_password_page.dart';
import 'package:you_it/screens/auth/login_page.dart';
import 'package:you_it/screens/auth/signup_page.dart';
import 'package:you_it/screens/auth/welcome_page.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_with_group_list_page.dart';
import 'package:you_it/screens/general/chang_password.dart';
import 'package:you_it/screens/general/genaral_page.dart';
import 'package:you_it/screens/group/group_page.dart';
import 'package:you_it/screens/message/message_page.dart';

import './routes.dart';
import '../../screens/home/home_page.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.groupPage:
        {
          return MaterialPageRoute(builder: (_) => const GroupPage());
        }
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
      // case Routes.messageDetailPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const MessageDetailPage());
      //   }
      case Routes.messagePage:
        {
          return MaterialPageRoute(builder: (_) => const MessagePage());
        }
      // case Routes.editDescriptionPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const EditDescriptionPage());
      //   }
      // case Routes.editInfoPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const EditInfoPage());
      //   }
      // case Routes.editLinkPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const EditLinkPage());
      //   }
      // case Routes.editProfilePage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const EditProfilePage());
      //   }
      // case Routes.profilePage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const ProfilePage());
      //   }

      // case Routes.activityPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const ActivityPage());
      //   }
      // case Routes.postingPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const PostingPage());
      //   }
      // case Routes.uploadFilePage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const UploadFilePage());
      //   }
      case Routes.generalPage:
        {
          return MaterialPageRoute(builder: (_) => const GeneralPage());
        }
      // case Routes.bottomNavBarPage:
      //   {
      //     return MaterialPageRoute(
      //         builder: (_) => const BottomNavBarPage(
      //               groupId: '',
      //               groupName: '',
      //             ));
      //   }
      case Routes.bottomNavBarWithGroupListPage:
        {
          return MaterialPageRoute(
              builder: (_) => const BottomNavBarWithGroupListPage());
        }
      case Routes.fillInfoPage:
        {
          return MaterialPageRoute(builder: (_) => const FillInfoPage());
        }
      case Routes.forgotPasswordPage:
        {
          return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
        }
      case Routes.changePasswordPage:
        {
          return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
        }
      // case Routes.addMemberPage:
      //   {
      //     return MaterialPageRoute(builder: (_) => const AddMemberPage());
      //   }
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
