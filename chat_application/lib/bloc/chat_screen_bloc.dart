import 'package:bloc/bloc.dart';
import 'package:chat_application/core/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_application/model/message_model.dart';
import 'package:chat_application/repositories/chat_repository.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final ChatRepository _chatRepository;
  List<MessageModel> _messages = [];

  ChatScreenBloc({ChatRepository? chatRepository})
    : _chatRepository = chatRepository ?? getIt<ChatRepository>(),
      super(ChatScreenInitial()) {
    on<FetchMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onLoadMessages(
    FetchMessagesEvent event,
    Emitter<ChatScreenState> emit,
  ) async {
    emit(ChatScreenLoading());
    try {
      _messages = await _chatRepository.getMessages();
      emit(ChatScreenLoaded(_messages));
    } catch (e) {
      emit(ChatScreenError('Failed to load messages'));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatScreenState> emit,
  ) async {
    try {
      if (state is ChatScreenLoaded &&
          (event.text.trim().isNotEmpty || event.isVoiceMessage)) {
        // Send user message
        final newMessage = await _chatRepository.sendMessage(
          event.text,
          isVoiceMessage: event.isVoiceMessage,
        );
        _messages = [..._messages, newMessage];
        emit(ChatScreenLoaded(_messages));

        // Add dummy response after a short delay
        await Future.delayed(const Duration(seconds: 1));
        final dummyResponse = MessageModel(
          text: "This is an automated response",
          isSentByMe: false,
          isVoiceMessage: false,
        );
        _messages = [..._messages, dummyResponse];
        emit(ChatScreenLoaded(_messages));
      }
    } catch (e) {
      emit(ChatScreenError('Failed to send message'));
    }
  }
}
