class ChatDetailModel {
  ChatDetailModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  ChatDetailModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatDetailData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<ChatDetailData>? data;
  String? message;
  num? lastPage;
ChatDetailModel copyWith({  bool? success,
  List<ChatDetailData>? data,
  String? message,
  num? lastPage,
}) => ChatDetailModel(  success: success ?? this.success,
  data: data ?? this.data,
  message: message ?? this.message,
  lastPage: lastPage ?? this.lastPage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['last_page'] = lastPage;
    return map;
  }

}

class ChatDetailData {
  ChatDetailData({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.message, 
      this.createdAt, 
      this.sender, 
      this.receiver,});

  ChatDetailData.fromJson(dynamic json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    createdAt = json['created_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  num? id;
  num? senderId;
  num? receiverId;
  String? message;
  String? createdAt;
  Sender? sender;
  Receiver? receiver;
  ChatDetailData copyWith({  num? id,
  num? senderId,
  num? receiverId,
  String? message,
  String? createdAt,
  Sender? sender,
  Receiver? receiver,
}) => ChatDetailData(  id: id ?? this.id,
  senderId: senderId ?? this.senderId,
  receiverId: receiverId ?? this.receiverId,
  message: message ?? this.message,
  createdAt: createdAt ?? this.createdAt,
  sender: sender ?? this.sender,
  receiver: receiver ?? this.receiver,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['message'] = message;
    map['created_at'] = createdAt;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    if (receiver != null) {
      map['receiver'] = receiver?.toJson();
    }
    return map;
  }

}

class Receiver {
  Receiver({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.profileImage,});

  Receiver.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? name;
  String? email;
  String? role;
  String? profileImage;
Receiver copyWith({  num? id,
  String? name,
  String? email,
  String? role,
  String? profileImage,
}) => Receiver(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  role: role ?? this.role,
  profileImage: profileImage ?? this.profileImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['profile_image'] = profileImage;
    return map;
  }

}

class Sender {
  Sender({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.profileImage,});

  Sender.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? name;
  String? email;
  String? role;
  dynamic profileImage;
Sender copyWith({  num? id,
  String? name,
  String? email,
  String? role,
  dynamic profileImage,
}) => Sender(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  role: role ?? this.role,
  profileImage: profileImage ?? this.profileImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['profile_image'] = profileImage;
    return map;
  }

}