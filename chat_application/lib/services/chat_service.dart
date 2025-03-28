import 'package:chat_application/model/message_model.dart';

class ChatService {
  Future<List<MessageModel>> fetchMessages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy API response
    return [
      MessageModel(text: "Morning", isSentByMe: false),
      MessageModel(text: "Have you watched the movie?", isSentByMe: false),
      MessageModel(text: "What movie?", isSentByMe: true),
      MessageModel(text: "Avengers", isSentByMe: false),
      MessageModel(text: "30''", isSentByMe: true, isVoiceMessage: true),
      MessageModel(
        text: "OK. I got your message by the way",
        isSentByMe: false,
      ),
      MessageModel(text: "Come on~", isSentByMe: true),
      MessageModel(text: "32''", isSentByMe: true, isVoiceMessage: true),
    ];
  }

  Future<MessageModel> sendMessage(
    String text, {
    bool isVoiceMessage = false,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return MessageModel(
      text: text,
      isSentByMe: true,
      isVoiceMessage: isVoiceMessage,
    );
  }
}
