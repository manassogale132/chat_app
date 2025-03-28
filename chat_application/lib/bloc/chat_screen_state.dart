part of 'chat_screen_bloc.dart';

sealed class ChatScreenState extends Equatable {
  const ChatScreenState();
  
  @override
  List<Object> get props => [];
}

final class ChatScreenInitial extends ChatScreenState {}

final class ChatScreenLoading extends ChatScreenState {}

final class ChatScreenLoaded extends ChatScreenState {
  final List<MessageModel> messages;

  const ChatScreenLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

final class ChatScreenError extends ChatScreenState {
  final String message;

  const ChatScreenError(this.message);

  @override
  List<Object> get props => [message];
}
