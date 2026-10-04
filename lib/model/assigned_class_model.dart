class AssignedClassModel {
  AssignedClassModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  AssignedClassModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AssignedClassData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<AssignedClassData>? data;
  String? message;
  String? lastPage;
AssignedClassModel copyWith({  bool? success,
  List<AssignedClassData>? data,
  String? message,
  String? lastPage,
}) => AssignedClassModel(  success: success ?? this.success,
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

class AssignedClassData {
  AssignedClassData({
      this.id, 
      this.userId, 
      this.standardId, 
      this.divisionId, 
      this.subjectId, 
      this.academicYearId, 
      this.standard, 
      this.division, 
      this.subject,});

  AssignedClassData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    divisionId = json['division_id'];
    subjectId = json['subject_id'];
    academicYearId = json['academic_year_id'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }
  num? id;
  num? userId;
  num? standardId;
  num? divisionId;
  num? subjectId;
  num? academicYearId;
  Standard? standard;
  Division? division;
  Subject? subject;
  AssignedClassData copyWith({  num? id,
  num? userId,
  num? standardId,
  num? divisionId,
  num? subjectId,
  num? academicYearId,
  Standard? standard,
  Division? division,
  Subject? subject,
}) => AssignedClassData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  divisionId: divisionId ?? this.divisionId,
  subjectId: subjectId ?? this.subjectId,
  academicYearId: academicYearId ?? this.academicYearId,
  standard: standard ?? this.standard,
  division: division ?? this.division,
  subject: subject ?? this.subject,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    map['division_id'] = divisionId;
    map['subject_id'] = subjectId;
    map['academic_year_id'] = academicYearId;
    if (standard != null) {
      map['standard'] = standard?.toJson();
    }
    if (division != null) {
      map['division'] = division?.toJson();
    }
    if (subject != null) {
      map['subject'] = subject?.toJson();
    }
    return map;
  }

}

class Subject {
  Subject({
      this.id, 
      this.name, 
      this.standardId, 
      this.standard,});

  Subject.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    standardId = json['standard_id'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
  }
  num? id;
  String? name;
  num? standardId;
  Standard? standard;
Subject copyWith({  num? id,
  String? name,
  num? standardId,
  Standard? standard,
}) => Subject(  id: id ?? this.id,
  name: name ?? this.name,
  standardId: standardId ?? this.standardId,
  standard: standard ?? this.standard,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['standard_id'] = standardId;
    if (standard != null) {
      map['standard'] = standard?.toJson();
    }
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


