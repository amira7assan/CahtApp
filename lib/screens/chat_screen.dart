import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message.dart';
import '../widgets/chatBuble.dart';
import 'package:scholar_chat/constants.dart';
class ChatScreen extends StatefulWidget {

static String id = 'chatPage';

State<ChatScreen> createState() => _ChatScreenState();
}
final _controller = ScrollController();
class _ChatScreenState extends State<ChatScreen> {
CollectionReference messages = FirebaseFirestore.instance.collection(kMessageCollection);

TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String? ?? '';
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt,descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message> messagelist =[];
            for(int i=0 ;i < snapshot.data!.docs.length;i++)
            {messagelist.add(Message.fromjson(snapshot.data!.docs[i]));}
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo, height: 40 , ),
                  Text('chat',style: TextStyle(color: Colors.white,),
                  )
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
                children:[
                  Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagelist.length,
                      itemBuilder: (context,index){
                        return messagelist[index].id == email ? chatBuble(
                            message: messagelist[index],
                        ):chatBuble2(message: messagelist[index],) ;
                      }),
                ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data){
                        messages.add({
                          kMessage :data,
                          kcreatedAt : DateTime.now(),
                          'id' : email,
                        });
                        controller.clear();
                        _controller.animateTo(
                            0,
                            duration: Duration(microseconds: 500),
                            curve: Curves.easeIn
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send message',
                        suffixIcon: Icon(Icons.send,
                          color: kPrimaryColor,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kPrimaryColor)
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          );
        }
        else{
          return const Text("Loading....");
        }
      },
    );
  }
}
