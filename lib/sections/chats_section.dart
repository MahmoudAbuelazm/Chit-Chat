import 'package:chitchat/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import '../model/chat_model.dart';
import '../screens/select_contact_screen.dart';

class ChatsSection extends StatefulWidget {
  const ChatsSection({super.key});

  @override
  State<ChatsSection> createState() => _ChatsSectionState();
}

class _ChatsSectionState extends State<ChatsSection> {
  List<ChatModel> chats = [
    ChatModel(
      name: 'User Name',
      icon: Icons.person,
      isGroup: false,
      time: '10:00',
      currentMessage: 'Hello',
    ),
    ChatModel(
      name: 'Group Name',
      icon: Icons.groups,
      isGroup: true,
      time: '09:00',
      currentMessage: 'Hello',
    ),
    ChatModel(
      name: 'User Name',
      icon: Icons.person,
      isGroup: false,
      time: '08:00',
      currentMessage: 'Hello',
    ),
    ChatModel(
      name: 'Group Name',
      icon: Icons.groups,
      isGroup: true,
      time: '07:00',
      currentMessage: 'Hello',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => const SelectContactScreen(),
              ),
            );
          },
          backgroundColor: const Color(0xFF25D366),
          child: const Icon(Icons.chat),
        ),
        body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return CustomCard(
              chatModel: chats[index],
            );
          },
        ));
  }
}
