import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chitchat/sections/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../sections/video_view.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isFront = false;
  double angle = 0;

  @override
  void initState() {
    controller = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = controller!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CameraPreview(
                      controller!,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            color: Colors.black.withOpacity(0.3),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        controller!.setFlashMode(
                            flash ? FlashMode.torch : FlashMode.off);
                      },
                      icon: Icon(
                        flash ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    GestureDetector(
                      onLongPressUp: () async {
                        final path = join((await getTemporaryDirectory()).path,
                            "${DateTime.now()}.mp4");
                        await controller!.stopVideoRecording().then((value) {
                          value.saveTo(path);
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoView(
                                      path: path,
                                    )),
                          );
                        });
                      },
                      onLongPress: () async {
                        await controller!.startVideoRecording().then((value) {
                          setState(() {
                            isRecording = true;
                          });
                        });
                      },
                      onTap: () {
                        if (!isRecording) takePicture(context);
                      },
                      child: isRecording
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 80,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 70,
                            ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isFront = !isFront;
                          angle += pi;
                        });
                        controller = CameraController(
                            cameras[isFront ? 0 : 1], ResolutionPreset.high);
                        cameraValue = controller!.initialize();
                      },
                      icon: Transform.rotate(
                        angle: angle,
                        child: const Icon(Icons.flip_camera_ios,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Hold for video, tap for photo",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void takePicture(
    BuildContext context,
  ) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    await controller!.takePicture().then((value) {
      value.saveTo(path);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraView(
                  path: path,
                )),
      );
    });
  }
}
