import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/chat/data/repo/message_repo.dart';
import 'package:save_plant/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_plant/feature/chat/presentation/view/widgets/chatbot_view_body.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(ChatService(api: DioConsumer(dio: Dio()))),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: HeaderSection(title: 'Mahsoly Bot'),
          ),
          body: ChatBotViewBody(),
        ),
      ),
    );
  }
}
