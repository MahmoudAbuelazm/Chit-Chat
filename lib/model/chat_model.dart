import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatModel {
  static int _idCounter = 0;
  String name;
  IconData icon;
  bool isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  int id;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
    this.select = false,
    
  }) : id = _idCounter++;
}
