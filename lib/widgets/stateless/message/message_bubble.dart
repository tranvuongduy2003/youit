import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// A MessageBubble for showing a single chat message on the ChatScreen.
class MessageBubble extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
    this.imageUrl = null,
    this.fileUrl = null,
  }) : isFirstInSequence = true;

  // Create a amessage bubble that continues the sequence.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
    this.imageUrl = null,
    this.fileUrl = null,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // Whether or not this message bubble is the first in a sequence of messages
  // from the same user.
  // Modifies the message bubble slightly for these different cases - only
  // shows user image for the first message from the same user, and changes
  // the shape of the bubble for messages thereafter.
  final bool isFirstInSequence;

  // Image of the user to be displayed next to the bubble.
  // Not required if the message is not the first in a sequence.
  final String? userImage;

  // Username of the user.
  // Not required if the message is not the first in a sequence.
  final String? username;
  final String message;
  final String? imageUrl;
  final String? fileUrl;

  // Controls how the MessageBubble will be aligned.
  final bool isMe;

  handleDownloadFile(String url) async {
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
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (!isMe && userImage != null)
          Positioned(
            top: 20,
            // Align user image to the right, if the message is from me.
            right: isMe ? 0 : null,
            child: userImage != ''
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      userImage!,
                    ),
                    backgroundColor: Colors.black12,
                    radius: 23,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 23,
                  ),
          ),
        Container(
          // Add some margin to the edges of the messages, to allow space for the
          // user's image.
          margin: EdgeInsets.symmetric(horizontal: !isMe ? 39 : 0),
          child: Row(
            // The side of the chat screen the message should show at.
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // First messages in the sequence provide a visual buffer at
                  // the top.
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (!isMe && username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  // The "speech" box surrounding the message.
                  Container(
                    decoration: BoxDecoration(
                      color: isMe ? Color(0xFFF57C7C) : Color(0xFFF9BEBE),
                      // Only show the message bubble's "speaking edge" if first in
                      // the chain.
                      // Whether the "speaking edge" is on the left or right depends
                      // on whether or not the message bubble is the current user.
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    // Set some reasonable constraints on the width of the
                    // message bubble so it can adjust to the amount of text
                    // it should show.
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/placeholder.png'),
                              image: NetworkImage(imageUrl!),
                            ),
                          )
                        : fileUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 130,
                                      decoration:
                                          BoxDecoration(color: Colors.black87),
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.insert_drive_file,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'File',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      height: 40,
                                      width: 130,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.file_download,
                                          color: isMe
                                              ? Color(0xFFF57C7C)
                                              : Color(0xFFF9BEBE),
                                        ),
                                        onPressed: () =>
                                            handleDownloadFile(fileUrl!),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Text(
                                message,
                                style: TextStyle(
                                  // Add a little line spacing to make the text look nicer
                                  // when multilined.
                                  height: 1.3,
                                  color: theme.colorScheme.onSecondary,
                                ),
                                softWrap: true,
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
