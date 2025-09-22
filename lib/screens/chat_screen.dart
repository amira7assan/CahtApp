import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/screens/cubits/ChatCubit/chat_cubit.dart';
import '../widgets/chatBuble.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chatPage';
  State<ChatScreen> createState() => _ChatScreenState();
}

final _controller = ScrollController();

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messagelist = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String? ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 40,
            ),
            Text(
              'chat',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state){
                if(state is ChatSuccess){
                  messagelist = state.messages;
                }
              },
          builder: (context, state) {
              return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagelist.length,
                  itemBuilder: (context, index) {
                    return messagelist[index].id == email
                        ? chatBuble(
                            message: messagelist[index],
                          )
                        : chatBuble2(
                            message: messagelist[index],
                          );
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            onSubmitted: (data) {
              controller.clear();
              _controller.animateTo(0,
                  duration: Duration(microseconds: 500), curve: Curves.easeIn);
            },
            decoration: InputDecoration(
              hintText: 'Send message',
              suffixIcon: Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor)),
            ),
          ),
        ),
      ]),
    );
  }
}
