class MessageModel {
  final bool isUser;
  final String text;
  final String id;
  final String userId;

  MessageModel({
    required this.isUser,
    required this.text,
    required this.id,
    required this.userId,
  });
}
