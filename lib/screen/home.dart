import 'package:chat_app_project/functions/clientUser.dart';
import 'package:chat_app_project/models/usermodel.dart';
import 'package:chat_app_project/screen/chatScreen.dart';
import 'package:chat_app_project/screen/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void getUsers() async {
  //   var users = await fetchRegisteredUsers();
  //   print('All reg users : $users');
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Check if arguments is not null before accessing its values
    if (arguments != null) {
      String userName = arguments['userName'];
      int userId = arguments['userId'];
      //var LogedRoom = arguments['room_id'];

      return Scaffold(
          drawer: drawerpage(),
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color.fromARGB(255, 28, 168, 25),
            title: Text(
              'Chat App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius: 18,
              ),
              Center(
                child: Text(' $userName'.toUpperCase()),
              )
            ],
          ),
          body: FutureBuilder<List<UserList>>(
              future: fetchRegisteredUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else {
                  List<dynamic> users = snapshot.data ?? [];

                  users.removeWhere((user) => user.id == userId);

                  if (users.isNotEmpty) {
                    return ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          // print('...........');
                          // print(item.senderRoomId);
                          // print(item.msgTo);
                          //if (item.id != userId) {
                          return ListTile(
                            title: Text(item.name!.toUpperCase()),
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('assets/avatar.jpg'),
                            ),
                            onTap: () {
                              int? chatId = item.id;
                              //var logged_room_id = getroom();
                              fetchMessages(userId, chatId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chatScreen(
                                          name: item.name,
                                          id: userId,
                                          chatPersonId: item.id,
                                          room_Id: item.senderRoomId,
                                        )),
                              );
                            },
                          );
                        }
                        // },
                        );
                  } else {
                    return Center(child: Text('No registered users found.'));
                  }
                }
              }));
    } else {
      return Scaffold(
          body: Center(
        child: TextButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ));
    }
  }
}
