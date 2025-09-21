import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';

import '../constants.dart';

class chatBuble extends StatelessWidget {
  const chatBuble({
    Key? key,required this.message
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 16 , bottom: 16,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(message.message
            ,style: TextStyle(
              color: Colors.white,)),
      ),
    );
  }
}

class chatBuble2 extends StatelessWidget {
  const chatBuble2({
    Key? key,required this.message
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 16 , bottom: 16,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.teal,
        ),
        child: Text(message.message
            ,style: TextStyle(
              color: Colors.white,)),
      ),
    );
  }
}
