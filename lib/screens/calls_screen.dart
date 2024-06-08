import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          callCard(
            'Dad',
            Icons.call_received,
            Colors.green,
            'Today, 10:00 PM',
          ),
          callCard(
            'Mom',
            Icons.call_made,
            Colors.red,
            'Today, 9:00 PM',
          ),
          callCard(
            'Sister',
            Icons.call_missed,
            Colors.red,
            'Today, 8:00 PM',
          ),
          callCard(
            'Brother',
            Icons.call_received,
            Colors.green,
            'Today, 7:00 PM',
          ),
          callCard(
            'Friend',
            Icons.call_made,
            Colors.red,
            'Today, 6:00 PM',
          ),
          callCard(
            'Colleague',
            Icons.call_received,
            Colors.green,
            'Today, 5:00 PM',
          ),
          callCard(
            'Boss',
            Icons.call_made,
            Colors.red,
            'Today, 4:00 PM',
          ),
          callCard(
            'Wife',
            Icons.call_missed,
            Colors.red,
            'Today, 3:00 PM',
          ),
          callCard(
            'Husband',
            Icons.call_received,
            Colors.green,
            'Today, 2:00 PM',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_call),
      ),
    );
  }

  Widget callCard(
      String name, IconData iconData, Color iconColor, String time) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.only(bottom: .5),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25,
          ),
          title: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Row(
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              const SizedBox(width: 5),
              Text(
                time,
                style: const TextStyle(fontSize: 12.5),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.call,
            size: 30,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
