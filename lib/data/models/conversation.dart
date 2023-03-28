import 'package:uuid/uuid.dart';

import 'message.dart';

class ConversationModel {
  late final String id;
  late final DateTime createdAt;
  late final List<MessageModel> messages;

  ConversationModel.createNew() {
    id = const Uuid().v4();
    createdAt = DateTime.now();
    messages = [];
  }

  ConversationModel.fromLocal({
    required this.id,
    required this.createdAt,
    required this.messages,
  });
}
