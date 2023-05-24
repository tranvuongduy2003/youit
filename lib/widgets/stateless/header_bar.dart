import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isIconButton;
  final Widget title;
  final VoidCallback handler;
  HeaderBar({
    this.isIconButton = true,
    required this.title,
    required this.handler,
  });

  static const headerHeight = 67.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: headerHeight,
      leading: isIconButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: AppColors.fontColor,
              onPressed: handler,
            )
          : null,
      title: title,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.lineColor,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  Size get preferredSize => Size.fromHeight(headerHeight);
}
