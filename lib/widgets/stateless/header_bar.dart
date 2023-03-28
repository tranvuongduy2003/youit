import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

import '../../config/themes/app_colors.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final VoidCallback handler;

  HeaderBar({
    required this.appBar,
    required this.title,
    required this.handler,
  });

  static const headerHeight = 67.0;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = AppBarTheme.of(context);

    return AppBar(
      toolbarHeight: headerHeight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: AppColors.fontColor,
        onPressed: handler,
      ),
      title: Container(
        child: Text(
          title,
          style: AppTextStyles.appBarText,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.lineColor,
          height: 1.0,
        ),
      ),
      //backgroundColor: appBarTheme.backgroundColor,
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  Size get preferredSize => Size.fromHeight(headerHeight);
}