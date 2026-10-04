class DashboardModel {
  DashboardModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  DashboardModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  DashboardData? data;
  String? message;
  String? lastPage;
DashboardModel copyWith({  bool? success,
  DashboardData? data,
  String? message,
  String? lastPage,
}) => DashboardModel(  success: success ?? this.success,
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

class DashboardData {
  DashboardData({
      this.user, 
      this.myStudentsCount, 
      this.attendanceDate, 
      this.presentCount, 
      this.absentCount, 
      this.announcement,});

  DashboardData.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    myStudentsCount = json['my_students_count'];
    attendanceDate = json['attendance_date'];
    presentCount = json['present_count'];
    absentCount = json['absent_count'];
    announcement = json['announcement'] != null ? Announcement.fromJson(json['announcement']) : null;
  }
  User? user;
  num? myStudentsCount;
  String? attendanceDate;
  int? presentCount;
  int? absentCount;
  Announcement? announcement;
  DashboardData copyWith({  User? user,
  num? myStudentsCount,
  String? attendanceDate,
  int? presentCount,
  int? absentCount,
  Announcement? announcement,
}) => DashboardData(  user: user ?? this.user,
  myStudentsCount: myStudentsCount ?? this.myStudentsCount,
  attendanceDate: attendanceDate ?? this.attendanceDate,
  presentCount: presentCount ?? this.presentCount,
  absentCount: absentCount ?? this.absentCount,
  announcement: announcement ?? this.announcement,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['my_students_count'] = myStudentsCount;
    map['attendance_date'] = attendanceDate;
    map['present_count'] = presentCount;
    map['absent_count'] = absentCount;
    if (announcement != null) {
      map['announcement'] = announcement?.toJson();
    }
    return map;
  }

}

class Announcement {
  Announcement({
      this.id, 
      this.userId, 
      this.title, 
      this.description, 
      this.startDate, 
      this.endDate, 
      this.status,});

  Announcement.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }
  num? id;
  num? userId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? status;
Announcement copyWith({  num? id,
  num? userId,
  String? title,
  String? description,
  String? startDate,
  String? endDate,
  String? status,
}) => Announcement(  id: id ?? this.id,
  userId: userId ?? this.userId,
  title: title ?? this.title,
  description: description ?? this.description,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['status'] = status;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.username, 
      this.name, 
      this.email, 
      this.mobile, 
      this.profileImage, 
      this.role, 
      this.school, 
      this.classTeacherOf,});

  User.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    role = json['role'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    classTeacherOf = json['class_teacher_of'];
  }
  num? id;
  String? username;
  String? name;
  String? email;
  String? mobile;
  dynamic profileImage;
  String? role;
  School? school;
  String? classTeacherOf;
User copyWith({  num? id,
  String? username,
  String? name,
  String? email,
  String? mobile,
  dynamic profileImage,
  String? role,
  School? school,
  String? classTeacherOf,
}) => User(  id: id ?? this.id,
  username: username ?? this.username,
  name: name ?? this.name,
  email: email ?? this.email,
  mobile: mobile ?? this.mobile,
  profileImage: profileImage ?? this.profileImage,
  role: role ?? this.role,
  school: school ?? this.school,
  classTeacherOf: classTeacherOf ?? this.classTeacherOf,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['profile_image'] = profileImage;
    map['role'] = role;
    if (school != null) {
      map['school'] = school?.toJson();
    }
    map['class_teacher_of'] = classTeacherOf;
    return map;
  }

}

class School {
  School({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.profileImage,});

  School.fromJson(dynamic json) {
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
School copyWith({  num? id,
  String? name,
  String? email,
  String? role,
  String? profileImage,
}) => School(  id: id ?? this.id,
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