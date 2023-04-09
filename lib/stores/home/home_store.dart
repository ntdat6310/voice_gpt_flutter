import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';

import '../../data/models/conversation.dart';
import '../../data/services/local_storage_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @readonly
  late ObservableList<ConversationModel> _conversations;

  _HomeStoreBase() : _conversations = LocalStorageService.getConversations() {}

  @action
  ConversationModel createNewConversation() {
    return ConversationModel.withMessages(
      createdAt: DateTime.now(),
      messageList: [],
      messageObservable: ObservableList<MessageModel>(),
    );
  }

  @action
  void addConversation(ConversationModel conversation) {
    _conversations.insert(0, conversation);
  }
}
