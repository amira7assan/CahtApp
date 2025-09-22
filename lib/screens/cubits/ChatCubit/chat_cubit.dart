import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';
import '../../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  void sendMessage ({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kcreatedAt: DateTime.now(),
      'id': email,
    });
  }
  void getMessages () {
    messages
        .orderBy(kcreatedAt, descending: true)
        .snapshots()
        .listen((event){
          print("success");
          List<Message> messagelist = [];
          for(var doc in event.docs)
            {
              messagelist.add(Message.fromjson(doc));
            }
          emit(ChatSuccess(messages: messagelist));
          print("object");

    }

    );}
}
