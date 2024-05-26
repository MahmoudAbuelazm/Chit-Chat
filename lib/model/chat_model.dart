import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatModel {
  String name;
  IconData icon;
  bool isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
     this.time,
     this.currentMessage,
    this.status,
    this.select = false,
  });
}
