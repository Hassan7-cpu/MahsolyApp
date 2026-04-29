import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/feature/chat/data/repo/message_repo.dart';
import 'package:save_plant/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_plant/feature/chat/presentation/view/widgets/chatbot_view_body.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = CacheHelper().getData(key: ApiKey.id);
    return BlocProvider(
      create: (_) => ChatCubit(ChatService(), userId),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(title: Text("Chatbot")),
          body: ChatBotViewBody(),
        ),
      ),
    );
  }
}
