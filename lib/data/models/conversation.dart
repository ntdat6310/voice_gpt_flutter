// conversation.dart
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import 'message.dart';

part 'conversation.g.dart';

@HiveType(typeId: 0)
class ConversationModel extends HiveObject {
  @HiveField(0)
  final DateTime createdAt;

  // Sử dụng kiểu List<MessageModel> để lưu trữ messages trong Hive
  @HiveField(1)
  List<MessageModel> messageList;

  late ObservableList<MessageModel> messageObservable;

  // Constructor không tên sẽ được sử dụng bởi Hive
  ConversationModel({
    required this.createdAt,
    required this.messageList
  });

  // Named constructor cho các trường hợp khác
  ConversationModel.withMessages({
    required this.createdAt,
    required this.messageList,
    required this.messageObservable,
  });

  void equalizeMessageList() {
    messageList = messageObservable.toList();
  }
}
