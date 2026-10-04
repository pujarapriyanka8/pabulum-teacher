class MyStudents {
  MyStudents({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  MyStudents.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MyStudent.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<MyStudent>? data;
  String? message;
  String? lastPage;
MyStudents copyWith({  bool? success,
  List<MyStudent>? data,
  String? message,
  String? lastPage,
}) => MyStudents(  success: success ?? this.success,
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

class MyStudent {
  MyStudent({
      this.id, 
      this.grNumber, 
      this.name, 
      this.username, 
      this.email, 
      this.mobile, 
      this.role, 
      this.profileImage, 
      this.address, 
      this.standard, 
      this.division, 
      this.rollNumber, 
      this.academicYear, 
      this.displayAcademicYear,});

  MyStudent.fromJson(dynamic json) {
    id = json['id'];
    grNumber = json['gr_number'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    role = json['role'];
    profileImage = json['profile_image'];
    address = json['address'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    rollNumber = json['roll_number'];
    academicYear = json['academic_year'] != null ? AcademicYear.fromJson(json['academic_year']) : null;
    displayAcademicYear = json['display_academic_year'];
  }
  num? id;
  String? grNumber;
  String? name;
  String? username;
  String? email;
  String? mobile;
  String? role;
  String? profileImage;
  String? address;
  Standard? standard;
  Division? division;
  String? rollNumber;
  AcademicYear? academicYear;
  String? displayAcademicYear;
  MyStudent copyWith({  num? id,
  String? grNumber,
  String? name,
  String? username,
  String? email,
  String? mobile,
  String? role,
  String? profileImage,
  String? address,
  Standard? standard,
  Division? division,
  String? rollNumber,
  AcademicYear? academicYear,
  String? displayAcademicYear,
}) => MyStudent(  id: id ?? this.id,
  grNumber: grNumber ?? this.grNumber,
  name: name ?? this.name,
  username: username ?? this.username,
  email: email ?? this.email,
  mobile: mobile ?? this.mobile,
  role: role ?? this.role,
  profileImage: profileImage ?? this.profileImage,
  address: address ?? this.address,
  standard: standard ?? this.standard,
  division: division ?? this.division,
  rollNumber: rollNumber ?? this.rollNumber,
  academicYear: academicYear ?? this.academicYear,
  displayAcademicYear: displayAcademicYear ?? this.displayAcademicYear,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gr_number'] = grNumber;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['mobile'] = mobile;
    map['role'] = role;
    map['profile_image'] = profileImage;
    map['address'] = address;
    if (standard != null) {
      map['standard'] = standard?.toJson();
    }
    if (division != null) {
      map['division'] = division?.toJson();
    }
    map['roll_number'] = rollNumber;
    if (academicYear != null) {
      map['academic_year'] = academicYear?.toJson();
    }
    map['display_academic_year'] = displayAcademicYear;
    return map;
  }

}

class AcademicYear {
  AcademicYear({
      this.id, 
      this.userId, 
      this.startDate, 
      this.endDate,});

  AcademicYear.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
  num? id;
  num? userId;
  String? startDate;
  String? endDate;
AcademicYear copyWith({  num? id,
  num? userId,
  String? startDate,
  String? endDate,
}) => AcademicYear(  id: id ?? this.id,
  userId: userId ?? this.userId,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }

}

class Division {
  Division({
      this.id, 
      this.userId, 
      this.standardId, 
      this.standard, 
      this.name,});

  Division.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
    name = json['name'];
  }
  num? id;
  num? userId;
  num? standardId;
  Standard? standard;
  String? name;
Division copyWith({  num? id,
  num? userId,
  num? standardId,
  Standard? standard,
  String? name,
}) => Division(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  standard: standard ?? this.standard,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    if (standard != null) {
      map['standard'] = standard?.toJson();
    }
    map['name'] = name;
    return map;
  }

}

class Standard {
  Standard({
      this.id, 
      this.name,});

  Standard.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
Standard copyWith({  num? id,
  String? name,
}) => Standard(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

