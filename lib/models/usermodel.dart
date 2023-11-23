//user list model...............

class UserList {
  String? email;
  int? id;
  String? name;
  String? password;
  String? senderRoomId;

  UserList({this.email, this.id, this.name, this.password, this.senderRoomId});

  UserList.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    password = json['password'];
    senderRoomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['room_id'] = senderRoomId;
    return data;
  }
}

//massge model.......................

class ChatMessage {
  int? id;
  String? message;
  String? messageFrom;
  String? messageTo;
  String? time;
  // int? login_Id;
  // int? chatPerson_id;

  ChatMessage({
    required this.id,
    required this.message,
    required this.messageFrom,
    required this.messageTo,
    this.time,
    // this.login_Id,
    // this.chatPerson_id
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    messageFrom = json['message_from'];
    messageTo = json['message_to'];
    time = json['time'];
    // login_Id = json['login_Id'];
    // chatPerson_id = json['chatperson_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> msg = new Map<String, dynamic>();
    msg['id'] = id;
    msg['message'] = message;
    msg['messageFrom'] = messageFrom;
    msg['messageTo'] = messageTo;
    msg['time'] = time;
    // msg['login_id'] = login_Id;
    // msg['chatperson_Id'] = chatPerson_id;
    return msg;
  }
}
