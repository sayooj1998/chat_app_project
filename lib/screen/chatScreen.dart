import 'package:chat_app_project/functions/clientUser.dart';

import 'package:chat_app_project/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatScreen extends StatefulWidget {
  //final int? itemId;
  final String? name;
  final int? id;
  final int? chatPersonId;
  final int? messageFrom;
  final int? messageTo;
  final String? text;
  final String? room_Id;

  chatScreen({
    this.name,
    this.id,
    this.chatPersonId,
    this.messageFrom,
    this.messageTo,
    this.text,
    this.room_Id,
  });

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  List<ChatMessage> messages = [];
  late int chatPersonId;
  late int loginId;
  String? messageContent;
  DateTime timeStamb = DateTime.now();
  var senderroom_id;
  TextEditingController messageController = TextEditingController();
  List<dynamic> receivedMessages = [];
  late IO.Socket socket;
  var room_id;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    room_id = widget.room_Id ?? 0;
    chatPersonId = widget.chatPersonId ?? 0;
    loginId = widget.id ?? 0;
    connectToSocket();
    fetchAndSetMessages();
  }

  Future<void> fetchAndSetMessages() async {
    try {
      List<ChatMessage> fetchedMessages =
          await fetchMessages(loginId, chatPersonId);
      fetchedMessages.sort((a, b) => a.time!.compareTo(b.time!));
      setState(() {
        receivedMessages = fetchedMessages;
      });
    } catch (error) {
      print('Error fetching messages: $error');
      // Handle the error appropriately, e.g., show an error message to the user
    }
  }

//get room id from sharedpreferences....................

  Future<String> getroom() async {
    var room_id = await getRoomId();
    return room_id;
  }

  void connectToSocket() async {
    String token = await getTokenFromSharedPreferences();

    socket = IO.io('https://dev1.bo-l.com/', <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'Authorization': 'Bearer $token'},
    });

    //socket.opts();

    socket.on('connect', (_) {
      print('Connected to the socket');
    });

    socket.on('message', (data) {
      // Handle received messages
      print(data);
      handleReceivedMessage(data);
    });

    socket.on('connect_error', (error) {
      print('Connection error: $error');
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });

    socket.connect();
  }

  // message sent ....................................

  void sendMessage(String message) async {
    var senderroomId = await getroom();

    var room_id = widget.room_Id;

    socket.emit('message', {
      'message_input': message,
      'sender': room_id,
      'receiver': senderroomId,
      'currenttime': DateTime.now().toLocal().toString(),
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void handleReceivedMessage(dynamic data) {
    print(data);
// {f_rid: 68843, msg: chh, t_rid: 30899, name: sayooj }
    try {
      setState(() {
        ChatMessage receivedMessage = ChatMessage(
          message: data['msg'],
          messageFrom: data['f_rid'],
          messageTo: data['t_rid'],
          time: DateTime.now().toString(),
          id: receivedMessages.length + 1,
        );

        messages.add(receivedMessage);
        receivedMessages.add(receivedMessage);

        senderroom_id = data['receiver'];
        room_id = data['sender'];
      });
    } catch (e) {
      print('Error handling received message: $e');
      print(e);
    }
  }

  void dispose() {
    // ignore: avoid_print
    receivedMessages = [];
    messages = [];
    messageController = TextEditingController();
    socket.disconnect();
    messageContent = '';

    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? name = widget.name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(name!.toUpperCase()),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
                color: Colors.white,
                child: Center(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: receivedMessages.length + messages.length,
                    separatorBuilder: (context, index) => Container(),
                    itemBuilder: (context, index) {
                      if (index < receivedMessages.length) {
                        // Display received messages
                        final receivedMessage = receivedMessages[index];
                        bool isSender =
                            widget.room_Id == receivedMessage.messageTo;
                        return ChatBubble(
                          clipper: ChatBubbleClipper1(
                            type: isSender
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble,
                          ),
                          margin: const EdgeInsets.only(top: 20),
                          alignment:
                              isSender ? Alignment.topRight : Alignment.topLeft,
                          backGroundColor: isSender
                              ? const Color.fromARGB(255, 223, 197, 117)
                              : const Color.fromARGB(255, 101, 172, 231),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: SelectableText(receivedMessage.message!),
                          ),
                        );
                      }

                      //else {
                      //   // Display messages sent by the user
                      //   final sentMessage =
                      //       messages[index - receivedMessages.length];
                      //   return ChatBubble(
                      //     clipper: ChatBubbleClipper1(
                      //       type: BubbleType.receiverBubble,
                      //     ),
                      //     margin: const EdgeInsets.only(top: 20),
                      //     alignment: Alignment.bottomLeft,
                      //     backGroundColor:
                      //         const Color.fromARGB(255, 223, 197, 117),
                      //     child: Container(
                      //       constraints: BoxConstraints(
                      //         maxWidth: MediaQuery.of(context).size.width * 0.7,
                      //       ),
                      //       child: SelectableText(sentMessage.message ?? ''),
                      //     ),
                      //   );
                      // }
                    },
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        String message = messageController.text;
                        sendMessage(message);
                        messageController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
