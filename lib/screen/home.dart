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
    return Scaffold(
        drawer: drawerpage(),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 28, 168, 25),
          title: const Text(
            'Chat App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
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
                if (users.isNotEmpty) {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];

                      return ListTile(
                        title: Text(item.name!.toUpperCase()),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.jpg'),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    chatScreen(name: item.name)),
                          );
                          ;
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No registered users found.'));
                }
              }
            }));
  }
}
