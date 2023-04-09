import 'package:hive_flutter/adapters.dart';
import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';

class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _singleton = LocalStorageService._internal();

  factory LocalStorageService() {
    return _singleton;
  }

  late Box<ConversationModel> conversationBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ConversationModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(SenderTypeAdapter());
    conversationBox = await Hive.openBox<ConversationModel>('conversations');
  }

  static Future<void> addConversation(ConversationModel conversation) async {
    print(
        "LocalStorageService - addConversation conversation.createAt ${conversation.createdAt.millisecondsSinceEpoch.toString()}");

    // conversationBox.add(conversation);
    // Nếu add vậy thì key đâu => K có key làm sao lấy ra?

    // Chuyển các messageObservableList sang messageList để lưu!
    conversation.equalizeMessageList();
    await _singleton.conversationBox
        .put(conversation.createdAt.millisecondsSinceEpoch.toString(),
            conversation)
        .then((_) {
      print(
          "LocalStorageService - addConversation - then conversation.createAt ${conversation.createdAt.millisecondsSinceEpoch.toString()}");
    }).catchError((error) {
      print("Error at LocalStorageService.addConversation" + error.toString());
      throw error;
    });
  }

  static Future<void> deleteConversation(ConversationModel conversation) async {
    await _singleton.conversationBox
        .delete(conversation.createdAt.millisecondsSinceEpoch.toString())
        .catchError((error) {
      print(
          "Error at LocalStorageService.deleteConversation" + error.toString());
      throw error;
    });
  }

  static ObservableList<ConversationModel> getConversations() {
    // Chuyển từ messageList sang messageObservableList
    // Sau đó clear messageList
    List<ConversationModel> newConversations =
        _singleton.conversationBox.values.toList();
    for (ConversationModel conversation in newConversations) {
      print("Key: ${_singleton.conversationBox.keyAt(0)}");
      print(
          "LocalStorageService - getConversations conversation.createAt ${conversation.createdAt.microsecondsSinceEpoch.toString()}");
      //// Cách 1 : Cả hai phương thức này đều tham chiếu đến cùng một đối tượng trong bộ nhớ
      //// Vậy nên khi messageList.clear() thì các đối tượng đc tham chiếu bởi cả messageList và messageObservable đều bị xóa
      //// Dẫn đến messageObservable cũng trống theo.
      // conversation.messageObservable = conversation.messageList.asObservable();
      // conversation.messageObservable = ObservableList.of(conversation.messageList);
      // conversation.messageList.clear();

      //// Cách 2 : Nếu muốn tạo một đối tượng mới và gán cho messageObservable thì có thể làm cách sau:
      conversation.messageObservable =
          ObservableList.of(List.from(conversation.messageList));
      //// Lúc này đã tạo một đối tượng mới và gán vào messageObservable
      //// => messageList.clear() không ảnh hưởng đến messageObservable nữa!
      // conversation.messageList.clear();

      //// Cách 3 : Ta thấy ở đây không cần phải tạo ra đối tượng mới
      //// Cứ giữ nguyên như cách 1, nhưng sẽ không cần phải gọi messageList.clear()
      //// Chỉ cần messageList = [] để bỏ tham chiếu là được.
      // conversation.messageObservable =
      //     ObservableList.of(List.from(conversation.messageList));
      // conversation.messageList = [];
      // I/flutter (32673): At _HomeStoreBase _conversations.length: 1
      // I/flutter (32673): At _HomeStoreBase messageObservable: 2
      // I/flutter (32673): At _HomeStoreBase messageList length: 0
      // I/flutter (32673): At _HomeStoreBase _conversations.length: 1
      // I/flutter (32673): At _HomeStoreBase messageObservable: 0
      // I/flutter (32673): At _HomeStoreBase messageList length: 0
      // Tại sao cách này lại tạo ra 2 lần kì vậy?
    }
    print("LocalStorageService getConversations done...");
    return newConversations.asObservable();
  }
}
