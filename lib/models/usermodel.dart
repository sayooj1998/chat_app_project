class UserList {
  String? email;
  int? id;
  String? name;
  String? password;

  UserList({this.email, this.id, this.name, this.password});

  UserList.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}
//  String? getEmail() {
//     return email;
//   }

//   int? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getPassword() {
//     return password;
//   }
// }

//massge model.......................

class Message {
  final String text;
  final bool isSender;

  Message({
    required this.text,
    required this.isSender,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      isSender: json['isSender'],
    );
  }
}
