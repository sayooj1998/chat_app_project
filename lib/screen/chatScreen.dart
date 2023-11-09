import 'package:chat_app_project/functions/clientUser.dart';
import 'package:chat_app_project/models/usermodel.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  //final int? itemId;
  final String? name;
  final int? id;
  chatScreen({this.name, this.id});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchAndLoadMessages();
  }

  Future<void> fetchAndLoadMessages() async {
    int loginId = 1;
    int chatPersonId = 5;

    try {
      List<Message> fetchedMessages =
          await fetchMessages(loginId, chatPersonId);
      setState(() {
        messages = fetchedMessages;
      });
    } catch (e) {
      // Handle error when fetching messages
      print('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(widget.name ?? ''),
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
                  //             child: ListView.builder(
                  //                  itemCount: _messages.length,
                  //                  itemBuilder: (context, index) {
                  //                  return _buildMessage(_messages[index]);
                  //   },
                  // );,
                  ),
            ),
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
                    icon: Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () {},
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
