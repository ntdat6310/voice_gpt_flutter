import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
enum SenderType {
  @HiveField(0)
  user,
  @HiveField(1)
  bot,
}

@HiveType(typeId: 2)
class MessageModel extends HiveObject {
  @HiveField(0)
  late final DateTime createAt;
  @HiveField(1)
  late final String content;
  @HiveField(2)
  late final SenderType senderType;

  // Add unnamed constructor for hive_generator
  MessageModel({
    required this.content,
    required this.senderType,
    required this.createAt,
  });

  MessageModel.fromLocalStorage({
    required this.content,
    required this.senderType,
    required this.createAt,
  });

  MessageModel.createNew({
    required this.content,
    required this.senderType,
  }) {
    createAt = DateTime.now();
  }
}
