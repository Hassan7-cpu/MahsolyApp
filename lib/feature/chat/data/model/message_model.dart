import 'package:save_plant/core/networking/api_constant.dart';

class ChatModel {
  final String reply;
  ChatModel({required this.reply});
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(reply: json[ApiKey.reply]);
}

class MessageModel {
  final String text;
  final bool isUser;

  MessageModel({required this.text, required this.isUser});

  Map<String, dynamic> toJson() {
    return {'text': text, 'isUser': isUser};
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(text: json['text'], isUser: json['isUser']);
  }
}
