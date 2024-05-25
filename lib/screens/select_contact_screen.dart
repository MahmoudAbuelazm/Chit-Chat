import 'package:flutter/material.dart';

import '../model/chat_model.dart';
import '../widgets/button_card.dart';
import '../widgets/contact_card.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  List<ChatModel> chat = [
    ChatModel(
      name: 'User Name',
      icon: Icons.person,
      isGroup: false,
      status: 'Hey there! I am using WhatsApp',
    ),
    ChatModel(
      name: 'Dev Stack',
      icon: Icons.person,
      isGroup: false,
      status: 'A full stack developer',
    ),
    ChatModel(
      name: 'Buddies',
      icon: Icons.person,
      isGroup: false,
      status: 'A Flutter developer',
    ),
    ChatModel(
      name: 'Flutter Dev',
      icon: Icons.person,
      isGroup: false,
      status: 'A Flutter developer',
    ),
    ChatModel(
      name: 'Samuel',
      icon: Icons.person,
      isGroup: false,
      status: 'A BackEnd developer',
    ),
    ChatModel(
      name: 'John Doe',
      icon: Icons.person,
      isGroup: false,
      status: 'A FrontEnd developer',
    ),
    ChatModel(
      name: 'Mary Jane',
      icon: Icons.person,
      isGroup: false,
      status: 'A UI/UX designer',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF075E54),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Select contact',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '256 contacts',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: () {},
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'Invite a friend',
                    child: Text('Invite a friend'),
                  ),
                  const PopupMenuItem(
                    value: 'Contacts',
                    child: Text('Contacts'),
                  ),
                  const PopupMenuItem(
                    value: 'Refresh',
                    child: Text('Refresh'),
                  ),
                  const PopupMenuItem(
                    value: 'Help',
                    child: Text('Help'),
                  ),
                ];
              },
              onSelected: (value) => {},
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: chat.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const ButtonCard(
                name: 'New group',
                icon: Icons.group,
              );
            } else if (index == 1) {
              return const ButtonCard(
                name: 'New contact',
                icon: Icons.person_add,
              );
            }
            return ContactCard(
              chatModel: chat[index - 2],
            );
          },
        ));
  }
}
