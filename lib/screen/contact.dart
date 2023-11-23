// import 'package:flutter/material.dart';

// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactListScreen extends StatefulWidget {
//   @override
//   _ContactListScreenState createState() => _ContactListScreenState();
// }

// class _ContactListScreenState extends State<ContactListScreen> {
//   List<Contact> _contacts = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadContacts();
//   }

//   Future<bool> _requestPermission() async {
//     var status = await Permission.contacts.status;
//     if (status != PermissionStatus.granted) {
//       var result = await Permission.contacts.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }

//   Future<List<Contact>> _getContacts() async {
//     bool permissionGranted = await _requestPermission();

//     if (permissionGranted) {
//       // Fetch contacts
//       Iterable<Contact> contacts = await ContactsService.getContacts();
//       return contacts.toList();
//     } else {
//       // Handle the case where permission is not granted
//       return [];
//     }
//   }

//   Future<void> _loadContacts() async {
//     List<Contact> contacts = await _getContacts();
//     setState(() {
//       _contacts = contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact List'),
//       ),
//       body: ListView.builder(
//         itemCount: _contacts.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_contacts[index].displayName.toString()),
//             subtitle: Text(_contacts[index].phones.toString()),
//           );
//         },
//       ),
//     );
//   }
// }
