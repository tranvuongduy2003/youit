import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditDescriptionPage extends StatefulWidget {
  const EditDescriptionPage({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  State<EditDescriptionPage> createState() => _EditDescriptionPageState();
}

class _EditDescriptionPageState extends State<EditDescriptionPage> {
  bool _isLoading = false;
  String description = '';
  final _formKey = GlobalKey<FormState>();

  void updateDescription() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .updateDescription(description);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      ShowSnackbar().showSnackBar(context, Colors.red, e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    description = widget.description;
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: updateDescription,
            child: _isLoading
                ? CircularProgressIndicator()
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
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mô tả',
                    labelStyle: AppTextStyles.labelTextField,
                    errorBorder: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  onChanged: (value) {
                    description = value;
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
