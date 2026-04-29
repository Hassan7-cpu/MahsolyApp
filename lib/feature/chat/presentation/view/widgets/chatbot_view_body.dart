import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // لأن reverse: true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
        final cubit = context.read<ChatCubit>();
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: cubit.messages.length,
                itemBuilder: (context, index) {
                  final message =
                      cubit.messages[cubit.messages.length - 1 - index];

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
              padding: EdgeInsets.all(10.sp),
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
                    onPressed: () {
                      final text = _controller.text;
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
