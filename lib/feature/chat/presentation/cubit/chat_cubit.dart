import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/chat/data/model/message_model.dart';
import 'package:save_plant/feature/chat/data/repo/message_repo.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatService, this.userId) : super(ChatInitial());

  final ChatService _chatService;
  final String userId;

  final List<MessageModel> _messages = [];

  List<MessageModel> get messages => _messages;

  bool _isClosed = false;

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  bool isPlantQuestion(String text) {
    final keywords = [
      "plant",
      "soil",
      "crop",
      "disease",
      "fruit",
      "apple",
      "farming",
    ];
    return keywords.any((e) => text.toLowerCase().contains(e));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // user message
    _messages.add(
      MessageModel(
        isUser: true,
        text: text,
        id: DateTime.now().toString(),
        userId: userId,
      ),
    );
    emit(ChatSuccess());
    emit(ChatLoading());

    if (!isPlantQuestion(text)) {
      _messages.add(
        MessageModel(
          isUser: false,
          text: "I only answer agriculture-related questions 🌱",
          id: DateTime.now().toString(),
          userId: userId,
        ),
      );

      if (_isClosed) return;
      emit(ChatSuccess());
      return;
    }

    try {
      final reply = await _chatService.sendMessage(text);

      if (_isClosed) return;

      _messages.add(
        MessageModel(
          isUser: false,
          text: reply,
          id: DateTime.now().toString(),
          userId: userId,
        ),
      );

      emit(ChatSuccess());
    } catch (e) {
      if (_isClosed) return;
      emit(ChatError("Something went wrong"));
    }
  }
}
