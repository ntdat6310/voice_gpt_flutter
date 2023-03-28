import 'package:uuid/uuid.dart';

enum SenderType { user, bot }

class MessageModel {
  late final String id;
  late final String conversationId;
  late final String content;
  late final SenderType senderType;
  late final DateTime timestamp;

  MessageModel.fromLocalStorage({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.senderType,
    required this.timestamp,
  });

  MessageModel.createNew({
    required this.conversationId,
    required this.content,
    required this.senderType,
  }) {
    id = const Uuid().v4();
    timestamp = DateTime.now();
  }
}
