enum SenderType { user, bot }

class MessageModel {
  final String id;
  final String conversationId;
  final String content;
  final SenderType senderType;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.senderType,
    required this.timestamp,
  });
}
