import 'package:chitchat/model/chat_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.grey[350],
          child: const Icon(Icons.person, size: 30, color: Colors.white),
        ),
        title: Text(chatModel.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(chatModel.status!, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
