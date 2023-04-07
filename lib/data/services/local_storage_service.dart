import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _singleton = LocalStorageService._internal();

  factory LocalStorageService() {
    return _singleton;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ConversationModelAdapter());
    // Hive.registerAdapter(MessageModelAdapter());
    // Hive.registerAdapter(SenderTypeAdapter());
    // await Hive.openBox<ConversationModel>('conversations');
    // await Hive.openBox<MessageModel>('messages');
  }
}
