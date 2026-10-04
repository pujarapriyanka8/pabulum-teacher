class AttendanceDetailModel {
  AttendanceDetailModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  AttendanceDetailModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? AttendanceDetailData.fromJson(json['data']) : null;
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  AttendanceDetailData? data;
  String? message;
  String? lastPage;
AttendanceDetailModel copyWith({  bool? success,
  AttendanceDetailData? data,
  String? message,
  String? lastPage,
}) => AttendanceDetailModel(  success: success ?? this.success,
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

class AttendanceDetailData {
  AttendanceDetailData({
      this.id, 
      this.userId, 
      this.standardId, 
      this.divisionId, 
      this.academicYearId, 
      this.date, 
      this.present, 
      this.absent, 
      this.attendanceStudents,});

  AttendanceDetailData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    divisionId = json['division_id'];
    academicYearId = json['academic_year_id'];
    date = json['date'];
    present = json['present'];
    absent = json['absent'];
    if (json['attendance_students'] != null) {
      attendanceStudents = [];
      json['attendance_students'].forEach((v) {
        attendanceStudents?.add(AttendanceStudents.fromJson(v));
      });
    }
  }
  num? id;
  num? userId;
  num? standardId;
  num? divisionId;
  num? academicYearId;
  String? date;
  num? present;
  num? absent;
  List<AttendanceStudents>? attendanceStudents;
  AttendanceDetailData copyWith({  num? id,
  num? userId,
  num? standardId,
  num? divisionId,
  num? academicYearId,
  String? date,
  num? present,
  num? absent,
  List<AttendanceStudents>? attendanceStudents,
}) => AttendanceDetailData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  divisionId: divisionId ?? this.divisionId,
  academicYearId: academicYearId ?? this.academicYearId,
  date: date ?? this.date,
  present: present ?? this.present,
  absent: absent ?? this.absent,
  attendanceStudents: attendanceStudents ?? this.attendanceStudents,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    map['division_id'] = divisionId;
    map['academic_year_id'] = academicYearId;
    map['date'] = date;
    map['present'] = present;
    map['absent'] = absent;
    if (attendanceStudents != null) {
      map['attendance_students'] = attendanceStudents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AttendanceStudents {
  AttendanceStudents({
      this.id, 
      this.userId, 
      this.attendanceId, 
      this.isPresent, 
      this.isPresentDisplay, 
      this.user,});

  AttendanceStudents.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    attendanceId = json['attendance_id'];
    isPresent = json['is_present'];
    isPresentDisplay = json['is_present_display'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? id;
  num? userId;
  num? attendanceId;
  num? isPresent;
  String? isPresentDisplay;
  User? user;
AttendanceStudents copyWith({  num? id,
  num? userId,
  num? attendanceId,
  num? isPresent,
  String? isPresentDisplay,
  User? user,
}) => AttendanceStudents(  id: id ?? this.id,
  userId: userId ?? this.userId,
  attendanceId: attendanceId ?? this.attendanceId,
  isPresent: isPresent ?? this.isPresent,
  isPresentDisplay: isPresentDisplay ?? this.isPresentDisplay,
  user: user ?? this.user,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['attendance_id'] = attendanceId;
    map['is_present'] = isPresent;
    map['is_present_display'] = isPresentDisplay;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.id, 
      this.grNumber, 
      this.name, 
      this.profileImage, 
      this.rollNumber,});

  User.fromJson(dynamic json) {
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
User copyWith({  num? id,
  String? grNumber,
  String? name,
  String? profileImage,
  String? rollNumber,
}) => User(  id: id ?? this.id,
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