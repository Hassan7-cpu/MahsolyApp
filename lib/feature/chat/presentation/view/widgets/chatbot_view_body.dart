import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/feature/chat/data/model/message_model.dart';
import 'package:save_plant/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_plant/feature/chat/presentation/cubit/chat_state.dart';
import 'package:save_plant/feature/chat/presentation/view/widgets/type_indicator.dart';

import 'message.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<MessageModel> messages = [];

  late String email;

  @override
  void initState() {
    super.initState();

    final storedEmail = CacheHelper().getData(key: ApiKey.email);

    if (storedEmail == null || storedEmail is! String) return;

    email = storedEmail;

    loadMessages();
  }

  Future<void> saveMessages() async {
    final encoded = jsonEncode(messages.map((e) => e.toJson()).toList());

    await CacheHelper().saveData(key: 'chat_$email', value: encoded);
  }

  Future<void> loadMessages() async {
    final data = CacheHelper().getData(key: 'chat_$email');

    if (data == null) return;

    final List decodedList = jsonDecode(data);

    messages = decodedList.map((e) => MessageModel.fromJson(e)).toList();

    setState(() {});
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) async {
        if (state is ChatSuccess) {
          messages.add(
            MessageModel(text: state.chatModel.reply, isUser: false),
          );

          await saveMessages();

          setState(() {});
        }

        if (state is ChatError) {
          messages.add(MessageModel(text: state.error, isUser: false));

          await saveMessages();

          setState(() {});
        }

        _scrollToBottom();
      },

      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];

                  return Messages(isUser: message.isUser, text: message.text);
                },
              ),
            ),

            if (state is ChatLoading)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(8.sp),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 10.sp,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const TypingIndicator(),
                ),
              ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask about plants...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.sp),
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      final text = _controller.text.trim();

                      if (text.isEmpty) return;

                      setState(() {
                        messages.add(MessageModel(text: text, isUser: true));
                      });

                      await saveMessages();

                      _controller.clear();

                      context.read<ChatCubit>().sendMessage(text);

                      _scrollToBottom();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
