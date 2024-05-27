import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.path});
  final String path;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
              child: controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
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
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
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
