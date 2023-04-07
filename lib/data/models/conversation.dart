import 'package:mobx/mobx.dart';

import 'message.dart';

class ConversationModel {
  // Lấy createAt làm id luôn.
  final DateTime createdAt;

  // Dùng ObservableList để Mobx có thể theo dõi conversation.messages
  // Nếu chỉ dùng List, khi messages (property) thay đổi thì conversation vẫn không đổi
  // => Mobx không nhận biết được => Các reaction sẽ không chạy, UI sẽ không update

  final ObservableList<MessageModel> messages;

  ConversationModel._({
    required this.createdAt,
    required this.messages,
  });

  factory ConversationModel.createNew() {
    return ConversationModel._(
      createdAt: DateTime.now(),
      messages: ObservableList<MessageModel>(),
    );
  }

  factory ConversationModel.fromLocal({
    required DateTime createdAt,
    required List<MessageModel> messages,
  }) {
    return ConversationModel._(
      createdAt: createdAt,
      messages: ObservableList<MessageModel>.of(messages),
    );
  }
}