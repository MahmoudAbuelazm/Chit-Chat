import 'package:flutter/material.dart';

class OwnMessage extends StatelessWidget {
  const OwnMessage({super.key, required this.message, required this.time});
  final String message;
  final String time ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        child:  Card(
          elevation: 1,
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          margin:const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          color: const Color(0xFFDCF8C6),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 40, top: 5, bottom: 20),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
               Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style:const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.done_all,
                      color: Colors.blue,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
