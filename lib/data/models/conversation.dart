import 'message.dart';

class ConversationModel {
  final String id;
  final DateTime createdAt;
  final List<MessageModel> messages;

  ConversationModel(this.createdAt, this.messages, {required this.id});
}
