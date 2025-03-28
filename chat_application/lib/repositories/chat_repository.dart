import 'package:chat_application/core/service_locator.dart';
import 'package:chat_application/model/message_model.dart';
import 'package:chat_application/services/chat_service.dart';

class ChatRepository {
  final ChatService _chatService;

  ChatRepository({ChatService? chatService})
    : _chatService = chatService ?? getIt<ChatService>();

  Future<List<MessageModel>> getMessages() async {
    try {
      return await _chatService.fetchMessages();
    } catch (e) {
      throw Exception('Failed to fetch messages: $e');
    }
  }

  Future<MessageModel> sendMessage(
    String text, {
    bool isVoiceMessage = false,
  }) async {
    try {
      return await _chatService.sendMessage(
        text,
        isVoiceMessage: isVoiceMessage,
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
