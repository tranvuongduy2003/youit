import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditLinkPage extends StatefulWidget {
  const EditLinkPage({
    Key? key,
    required this.githubLink,
    required this.gitlabLink,
    required this.linkedin,
  }) : super(key: key);

  final String githubLink;
  final String gitlabLink;
  final String linkedin;

  @override
  State<EditLinkPage> createState() => _EditLinkPageState();
}

class _EditLinkPageState extends State<EditLinkPage> {
  String github = '';
  String gitlab = '';
  String linkedin = '';
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    github = widget.githubLink;
    gitlab = widget.gitlabLink;
    linkedin = widget.linkedin;
  }

  final formKey = GlobalKey<FormState>();

  updateLink() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (formKey.currentState!.validate()) {
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .updateUserLinkData(github, gitlab, linkedin);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      ShowSnackbar().showSnackBar(context, Colors.red, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = AppBarTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: TextButton(
          child: const Text(
            'Huỷ',
            style: AppTextStyles.appbarButtonTitle,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: AppTextStyles.sectionTitle,
        ),
        actions: [
          TextButton(
            onPressed: updateLink,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Lưu',
                    style: AppTextStyles.appbarButtonTitle,
                  ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.lineColor,
            height: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.githubLink,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Github',
                    labelStyle: AppTextStyles.labelTextField,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập đầy đủ';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    github = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.gitlabLink,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Gitlab',
                    labelStyle: AppTextStyles.labelTextField,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập đầy đủ';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    gitlab = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.linkedin,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Linkedin',
                    labelStyle: AppTextStyles.labelTextField,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập đầy đủ';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    linkedin = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
