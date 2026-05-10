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

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(
      MessageModel(
        isUser: true,
        text: text,
        id: DateTime.now().toString(),
        userId: userId,
      ),
    );

    emit(ChatLoading());

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
      emit(ChatError("⚠️ Something went wrong, try again"));
    }
  }
}
