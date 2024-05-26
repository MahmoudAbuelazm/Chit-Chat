import 'dart:io';

import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
              )),
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.title, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 27),
            onPressed: () {},
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 8,
                ),
                child: TextFormField(
                  maxLength: 6,
                  minLines: 1,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.tealAccent[700],
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'Add a caption...',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    prefixIcon: const Icon(Icons.add_photo_alternate,
                        size: 27, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}