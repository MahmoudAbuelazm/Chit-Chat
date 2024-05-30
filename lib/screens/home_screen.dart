// import 'package:chitchat/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../sections/camera_section.dart';
import '../sections/chats_section.dart';
import 'status_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    //  required this.sourcechat, required this.chatmodels
  });
  // final ChatModel sourcechat;
  // final List<ChatModel> chatmodels;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF075E54),
          title: const Text('Chit Chat'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      child: Text('New group'),
                    ),
                    const PopupMenuItem(
                      child: Text('New broadcast'),
                    ),
                    const PopupMenuItem(
                      child: Text('WhatsApp Web'),
                    ),
                    const PopupMenuItem(
                      child: Text('Starred messages'),
                    ),
                    const PopupMenuItem(
                      child: Text('Settings'),
                    )
                  ];
                },
                onSelected: (value) => {})
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            CameraSection(),
            ChatsSection(),
            StatusPage(),
            Center(
              child: Text('Calls'),
            ),
          ],
        ));
  }
}
