// import 'package:mobx/mobx.dart';
//
// import '../../data/models/conversation.dart';
//
// part 'conversation_store.g.dart';
//
// class ConversationStore = _ConversationStoreBase with _$ConversationStore;
//
// abstract class _ConversationStoreBase with Store {
//   @observable
//   late final List<ConversationModel> _conversations;
//
//   Future<List<ConversationModel>> _loadConversationsFromSqflite() async {}
//
//   _ConversationStoreBase() {
//     // Load conversations from SQLite.
//     _loadConversationsFromSqflite().then((loadedConversations) {
//       _conversations = loadedConversations ?? [];
//     });
//   }
// }
