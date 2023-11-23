// import 'package:hive/hive.dart';
// import 'package:chat_app_project/models/msg_model.dart';

// class HiveDatabaseService {
//   static const String _messageBox = 'messages';

//   Future<void> addMessage(Message message) async {
//     final box = await Hive.openBox<Message>(_messageBox);
//     box.add(message);
//   }

//   Future<List<Message>> getMessages() async {
//     final box = await Hive.openBox<Message>(_messageBox);
//     return box.values.toList();
//   }
// }
