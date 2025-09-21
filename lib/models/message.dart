import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
class Message{
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromjson(jsonData){
    return Message(jsonData[kMessage],jsonData['id']);
   }
}