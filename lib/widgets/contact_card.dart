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
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            chatModel.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      title: Text(chatModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(chatModel.status!, style: const TextStyle(fontSize: 14)),
    );
  }
}
