import 'package:flutter/material.dart';

import '../model/chat_model.dart';
import '../widgets/avatar_card.dart';
import '../widgets/contact_card.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  State<NewGroup> createState() => NewGroupState();
}

class NewGroupState extends State<NewGroup> {
  List<ChatModel> chat = [
    ChatModel(
      name: 'Monica',
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
    ChatModel(
      name: 'Jane Doe',
      icon: Icons.person,
      isGroup: false,
      status: 'A UI/UX designer',
    ),
    ChatModel(
      name: 'John Smith',
      icon: Icons.person,
      isGroup: false,
      status: 'A FrontEnd developer',
    ),
  ];
  List<ChatModel> group = [];
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
              'New group',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Add participants',
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: chat.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: group.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (chat[index].select == false) {
                    setState(() {
                      chat[index].select = true;
                      group.add(chat[index]);
                    });
                  } else {
                    setState(() {
                      chat[index].select = false;
                      group.remove(chat[index]);
                    });
                  }
                },
                child: ContactCard(
                  chatModel: chat[index],
                ),
              );
            },
          ),
          group.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: group.length,
                        itemBuilder: (context, index) {
                          if (group[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  group[index].select = false;
                                  group.remove(group[index]);
                                });
                              },
                              child: AvatarCard(
                                chatModel: group[index],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                          // return InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         group.remove(group[index]);
                          //       });
                          //     },
                          //     child: AvatarCard(
                          //       chatModel: group[index],
                          //     ));
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
