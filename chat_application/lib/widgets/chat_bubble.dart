import 'package:chat_application/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  String _formatTime() {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: message.isSentByMe ? 0 : 50,
            right: message.isSentByMe ? 50 : 0,
            bottom: 2,
          ),
          child: Text(
            message.isSentByMe ? "You" : "Manas🚀",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment:
              message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisAlignment:
                message.isSentByMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!message.isSentByMe)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      "https://www.profilebakery.com/wp-content/uploads/2024/05/Profile-picture-created-with-ai.jpeg",
                    ),
                  ),
                ),
              if (!message.isSentByMe) const SizedBox(width: 10),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          message.isSentByMe
                              ? Colors.blue
                              : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                            message.isSentByMe
                                ? const Radius.circular(16)
                                : Radius.zero,
                        bottomRight:
                            message.isSentByMe
                                ? Radius.zero
                                : const Radius.circular(16),
                      ),
                    ),
                    child:
                        message.isVoiceMessage
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    message.text,
                                    style: TextStyle(
                                      color:
                                          message.isSentByMe
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.mic,
                                  color:
                                      message.isSentByMe
                                          ? Colors.white
                                          : Colors.blue,
                                  size: 18,
                                ),
                              ],
                            )
                            : Text(
                              message.text,
                              style: TextStyle(
                                color:
                                    message.isSentByMe
                                        ? Colors.white
                                        : Colors.black87,
                                fontSize: 16,
                              ),
                              softWrap: true,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                  ),
                ),
              ),
              if (message.isSentByMe) const SizedBox(width: 10),
              if (message.isSentByMe)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS03S5lcE9VxQFC9mJkfa6SKFRN0G_YcQ7F4Q&s",
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: message.isSentByMe ? 0 : 50,
            right: message.isSentByMe ? 50 : 0,
            bottom: 8,
          ),
          child: Text(
            _formatTime(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
