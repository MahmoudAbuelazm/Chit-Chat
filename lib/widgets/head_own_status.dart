import 'package:flutter/material.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage:  NetworkImage(
                "https://th.bing.com/th/id/OIP.O6LAAwlf8Blf08xwD3HtGwHaHa?rs=1&pid=ImgDetMain"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.greenAccent[700],
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
      title: const Text(
        "My Status",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 14,
        ),
      ),
    );
  }
}
