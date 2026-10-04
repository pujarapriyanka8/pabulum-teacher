class ProfileModel {
  ProfileModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  ProfileModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  ProfileData? data;
  String? message;
  String? lastPage;
ProfileModel copyWith({  bool? success,
  ProfileData? data,
  String? message,
  String? lastPage,
}) => ProfileModel(  success: success ?? this.success,
  data: data ?? this.data,
  message: message ?? this.message,
  lastPage: lastPage ?? this.lastPage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['last_page'] = lastPage;
    return map;
  }

}

class ProfileData {
  ProfileData({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.profileImage, 
      this.token, 
      this.school,});

  ProfileData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    profileImage = json['profile_image'];
    token = json['token'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
  }
  num? id;
  String? name;
  String? email;
  String? role;
  dynamic profileImage;
  dynamic token;
  School? school;
  ProfileData copyWith({  num? id,
  String? name,
  String? email,
  String? role,
  dynamic profileImage,
  dynamic token,
  School? school,
}) => ProfileData(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  role: role ?? this.role,
  profileImage: profileImage ?? this.profileImage,
  token: token ?? this.token,
  school: school ?? this.school,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['profile_image'] = profileImage;
    map['token'] = token;
    if (school != null) {
      map['school'] = school?.toJson();
    }
    return map;
  }

}

class School {
  School({
      this.name, 
      this.profileImage,});

  School.fromJson(dynamic json) {
    name = json['name'];
    profileImage = json['profile_image'];
  }
  String? name;
  String? profileImage;
School copyWith({  String? name,
  String? profileImage,
}) => School(  name: name ?? this.name,
  profileImage: profileImage ?? this.profileImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['profile_image'] = profileImage;
    return map;
  }

}