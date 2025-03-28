part of 'chat_screen_bloc.dart';

sealed class ChatScreenEvent extends Equatable {
  const ChatScreenEvent();

  @override
  List<Object> get props => [];
}

final class FetchMessagesEvent extends ChatScreenEvent {}

final class SendMessageEvent extends ChatScreenEvent {
  final String text;
  final bool isVoiceMessage;

  const SendMessageEvent({
    required this.text,
    this.isVoiceMessage = false,
  });

  @override
  List<Object> get props => [text, isVoiceMessage];
}
