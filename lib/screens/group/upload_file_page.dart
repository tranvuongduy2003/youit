import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:you_it/service/database_service.dart';

import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/circle_button.dart';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({
    required this.groupId,
  });

  final String groupId;

  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  bool _loading = false;

  _handleUploadFile() async {
    setState(() {
      _loading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('files')
          .child('${result.files.single.name}');

      await storageRef.putFile(File(result.files.single.path!));
      final fileUrl = await storageRef.getDownloadURL();

      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      await DatabaseService(uid: user.uid).saveDocuments({
        'groupId': widget.groupId,
        'documentUrl': fileUrl,
        'senderId': user.uid,
        'senderName': userData['userName'],
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _loading = false;
    });
  }

  _handleDownloadFile(String url) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      final status = await Permission.notification.request();
      // print(status);

      if (status.isGranted) {
        final externalDir = await getExternalStorageDirectory();

        await FlutterDownloader.enqueue(
          url: url,
          savedDir: externalDir?.path ?? '',
          fileName: Path.basename(ref.name),
          showNotification: true,
          openFileFromNotification: true,
        );
      }
    } catch (e) {
      print(e);
      print('Permission deined');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 40),
        child: _loading
            ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(55)),
                child: Container(
                  height: 55,
                  width: 55,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColors.jordyBlue.withOpacity(0.36)),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              )
            : CircleButton(
                buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                onPressed: _handleUploadFile,
                imageAsset: 'assets/images/upload.png',
                size: 55,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('documents')
            .where('groupId', isEqualTo: widget.groupId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('An Error Occur');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.docs.isEmpty
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 1,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          alignment: Alignment.center,
                          height: double.maxFinite,
                          child: Text(
                            'Chưa có tệp tin nào \nđược tải lên',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: AppColors.startDust,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 0.55 - 48,
                            child: Text(
                              'Tệp tin',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 0.45 - 32,
                            child: Text(
                              'Người tải',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var data = snapshot.data!.docs[index];

                          final ref = FirebaseStorage.instance
                              .refFromURL(data['documentUrl']);
                          return Container(
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Color(0xFFF4F087).withOpacity(0.36),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55 -
                                          48,
                                  child: Text(
                                    ref.name,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45 -
                                          64,
                                  child: Text(
                                    data['senderName'],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  child: IconButton(
                                    onPressed: () => _handleDownloadFile(
                                        data['documentUrl']),
                                    icon: Icon(Icons.download),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
