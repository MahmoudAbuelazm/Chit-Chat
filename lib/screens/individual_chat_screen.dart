import 'dart:convert';

import 'package:chitchat/model/chat_model.dart';
import 'package:chitchat/sections/camera_view.dart';
import 'package:chitchat/widgets/own_file_card.dart';
import 'package:chitchat/widgets/reply_card.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;
import '../model/message_model.dart';
import '../widgets/own_message.dart';
import '../widgets/reply_file_card.dart';
import 'camera_screen.dart';

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen(
      {super.key, required this.chatModel, required this.sourechat});
  final ChatModel chatModel;
  final ChatModel sourechat;

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  io.Socket? socket;
  List<MessageModel> messages = [];
  bool sendbutton = false;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  int popetime = 0;
  @override
  void initState() {
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
    super.initState();
  }

  void connect() {
    socket = io.io(
      "",
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );
    socket!.connect();

    socket!.emit('message', 'Hello');
    socket!.onConnect((data) {
      print('Connected');
      socket!.on(
        'message',
        (msg) {
          print(msg);
          setMessage(
            "destination",
            msg["message"],
            path: msg["path"],
          );
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      );
    });
  }

  void sendMessage(String message, int sourceId, int targetId, {String? path}) {
    setMessage("source", message, path: path);
    socket!.emit('message', {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path
    });
    textEditingController.clear();
  }

  void setMessage(String type, String message, {String? path}) {
    setState(() {
      messages.add(MessageModel(
          type: type,
          message: message,
          time: DateTime.now().toString().substring(10, 16),
          path: path));
    });
  }

  void sendImage(String path, {String? message}) async {
    for (int i = 0; i < popetime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popetime = 0;
    });
    var request =
        http.MultipartRequest('POST', Uri.parse('http:/routes/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', path));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    var data = jsonDecode(res.body);
    print(response.statusCode);
    setMessage("source", message ?? "", path: path);
    socket!.emit('message', {
      "message": message,
      "sourceId": widget.sourechat.id,
      "targetId": widget.chatModel.id,
      "path": path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFF075E54),
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back, size: 24),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    widget.chatModel.icon,
                    size: 27,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'last seen today at ${widget.chatModel.time}',
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'View contact',
                    child: Text('View contact'),
                  ),
                  const PopupMenuItem(
                    value: 'Media, links, and docs',
                    child: Text('Media, links, and docs'),
                  ),
                  const PopupMenuItem(
                    value: 'Search',
                    child: Text('Search'),
                  ),
                  const PopupMenuItem(
                    value: 'Mute notifications',
                    child: Text('Mute notifications'),
                  ),
                  const PopupMenuItem(
                    value: 'Wallpaper',
                    child: Text('Wallpaper'),
                  ),
                ];
              },
              onSelected: (value) => {},
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: WillPopScope(
          onWillPop: () {
            if (showEmojiPicker) {
              setState(() {
                showEmojiPicker = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return const SizedBox(
                        height: 60,
                      );
                    }
                    if (messages[index].type == "source") {
                      if (messages[index].path != "" ||
                          messages[index].path != null) {
                        return OwnFileCard(
                          path: messages[index].path!,
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      } else {
                        return OwnMessage(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    } else {
                      if (messages[index].path != "" ||
                          messages[index].path != null) {
                        return ReplyFileCard(
                          path: messages[index].path!,
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      } else {
                        return ReplyCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Card(
                                margin: const EdgeInsets.only(
                                    left: 2, right: 2, bottom: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.attach_file,
                                            color: Color(0xFF128C7E),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet());
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.camera_alt,
                                              color: Color(0xFF128C7E)),
                                          onPressed: () {
                                            setState(() {
                                              popetime = 2;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CameraScreen(
                                                          onSend: sendImage,
                                                        )));
                                          },
                                        ),
                                      ],
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                          showEmojiPicker
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions,
                                          color: const Color(0xFF128C7E)),
                                      onPressed: () {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        setState(() {
                                          showEmojiPicker = !showEmojiPicker;
                                        });
                                        if (showEmojiPicker) {
                                        } else {
                                          focusNode.canRequestFocus = true;
                                          focusNode.requestFocus();
                                        }
                                      },
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Type a message',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        sendbutton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendbutton = false;
                                      });
                                    }
                                  },
                                )),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 4),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: const Color(0xFF128C7E),
                                child: IconButton(
                                  icon: Icon(
                                      sendbutton ? Icons.mic : Icons.send,
                                      color: Colors.white),
                                  onPressed: () {
                                    if (sendbutton) {
                                      scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                      sendMessage(
                                          textEditingController.text,
                                          widget.sourechat.id,
                                          widget.chatModel.id,
                                          path: "");
                                      textEditingController.clear();
                                      setState(() {
                                        sendbutton = false;
                                      });
                                    }
                                  },
                                )),
                          ),
                        ],
                      ),
                      showEmojiPicker ? emojiSelect() : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreate(Icons.insert_drive_file, 'Document', Colors.indigo,
                      () {}),
                  iconCreate(Icons.camera_alt, 'Camera', Colors.pink, () {
                    setState(() {
                      popetime = 3;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CameraScreen(
                        onSend: sendImage,
                      );
                    }));
                  }),
                  iconCreate(Icons.insert_photo, 'Gallery', Colors.purple,
                      () async {
                    setState(() {
                      popetime = 2;
                    });
                    file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CameraView(
                        path: file!.path,
                        onSend: sendImage,
                      );
                    }));
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreate(Icons.headset, 'Audio', Colors.orange, () {}),
                  iconCreate(
                      Icons.location_pin, 'Location', Colors.teal, () {}),
                  iconCreate(Icons.person, 'Contact', Colors.blue, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreate(IconData icon, String text, Color color, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: IconButton(
              icon: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        textEditingController.text = textEditingController.text + emoji.emoji;
      },
      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
        height: 256,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        skinToneConfig: const SkinToneConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
        categoryViewConfig: const CategoryViewConfig(),
      ),
    );
  }
}
