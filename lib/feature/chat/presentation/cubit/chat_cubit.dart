import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/chat/data/model/message_model.dart';
import 'package:save_plant/feature/chat/data/repo/message_repo.dart';
import 'package:save_plant/feature/chat/presentation/cubit/chat_state.dart'
    show ChatLoading, ChatSuccess, ChatError, ChatInitial, ChatState;

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;
  ChatCubit(this.chatService) : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    ChatModel chatModel;
    emit(ChatLoading());

    final result = await chatService.sendMessage(message: message);

    result.fold(
      (error) {
        emit(ChatError(error));
      },
      (data) {
        chatModel = ChatModel.fromJson(data);
        emit(ChatSuccess(chatModel: chatModel));
      },
    );
  }
}
