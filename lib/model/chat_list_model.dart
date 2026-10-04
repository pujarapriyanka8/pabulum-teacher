class ChatListModel {
  ChatListModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  ChatListModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatListData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<ChatListData>? data;
  String? message;
  String? lastPage;
ChatListModel copyWith({  bool? success,
  List<ChatListData>? data,
  String? message,
  String? lastPage,
}) => ChatListModel(  success: success ?? this.success,
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

class ChatListData {
  ChatListData({
      this.id, 
      this.grNumber, 
      this.name, 
      this.profileImage, 
      this.rollNumber,});

  ChatListData.fromJson(dynamic json) {
    id = json['id'];
    grNumber = json['gr_number'];
    name = json['name'];
    profileImage = json['profile_image'];
    rollNumber = json['roll_number'];
  }
  num? id;
  String? grNumber;
  String? name;
  String? profileImage;
  String? rollNumber;
  ChatListData copyWith({  num? id,
  String? grNumber,
  String? name,
  String? profileImage,
  String? rollNumber,
}) => ChatListData(  id: id ?? this.id,
  grNumber: grNumber ?? this.grNumber,
  name: name ?? this.name,
  profileImage: profileImage ?? this.profileImage,
  rollNumber: rollNumber ?? this.rollNumber,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gr_number'] = grNumber;
    map['name'] = name;
    map['profile_image'] = profileImage;
    map['roll_number'] = rollNumber;
    return map;
  }

}