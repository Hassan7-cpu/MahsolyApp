import 'package:save_plant/feature/chat/data/model/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final ChatModel chatModel;

  ChatSuccess({required this.chatModel});
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
