import 'package:chitchat/widgets/head_own_status.dart';
import 'package:flutter/material.dart';

import '../widgets/other_status.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 48,
            child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Colors.grey[100],
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.greenAccent[700],
            onPressed: () {},
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeadOwnStatus(),
            label("Recent updates"),
            const OtherStatus(
              name: "John Doe",
              time: "10:00 AM",
              isSeen: true,
              statusCount: 1,
              imageUrl:
                  "https://i.pinimg.com/originals/07/33/ba/0733ba760b29378474dea0fdbcb97107.png",
            ),
            const OtherStatus(
                name: "Andrew Mark",
                isSeen: true,
                time: "11:00 AM",
                statusCount: 3,
                imageUrl:
                    "https://th.bing.com/th/id/OIP.Dpo5c4turaXYS_n2eB_7egHaHa?w=512&h=512&rs=1&pid=ImgDetMain"),
            const OtherStatus(
              name: "Kevin Smith",
              time: "12:00 PM",
              statusCount: 2,
              isSeen: true,
              imageUrl:
                  "https://th.bing.com/th/id/R.5dcacb7894323b4dfbe63d10f1603491?rik=JsJa4Jq5JHDhVA&pid=ImgRaw&r=0",
            ),
            const SizedBox(height: 5),
            label("Viewed updates"),
            const OtherStatus(
              name: "John Doe",
              time: "10:00 AM",
              statusCount: 4,
              isSeen: false,
              imageUrl:
                  "https://i.pinimg.com/originals/07/33/ba/0733ba760b29378474dea0fdbcb97107.png",
            ),
            const OtherStatus(
                name: "Andrew Mark",
                time: "11:00 AM",
                statusCount: 1,
                isSeen: false,
                imageUrl:
                    "https://th.bing.com/th/id/OIP.Dpo5c4turaXYS_n2eB_7egHaHa?w=512&h=512&rs=1&pid=ImgDetMain"),
            const OtherStatus(
              name: "Kevin Smith",
              time: "12:00 PM",
              statusCount: 6,
              isSeen: false,
              imageUrl:
                  "https://th.bing.com/th/id/R.5dcacb7894323b4dfbe63d10f1603491?rik=JsJa4Jq5JHDhVA&pid=ImgRaw&r=0",
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String name) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
