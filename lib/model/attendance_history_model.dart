class AttendanceHistoryModel {
  AttendanceHistoryModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  AttendanceHistoryModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AttendanceHistory.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<AttendanceHistory>? data;
  String? message;
  num? lastPage;
AttendanceHistoryModel copyWith({  bool? success,
  List<AttendanceHistory>? data,
  String? message,
  num? lastPage,
}) => AttendanceHistoryModel(  success: success ?? this.success,
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

class AttendanceHistory {
  AttendanceHistory({
      this.id, 
      this.userId, 
      this.standardId, 
      this.divisionId, 
      this.academicYearId, 
      this.date, 
      this.presentCount, 
      this.absentCount,});

  AttendanceHistory.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    divisionId = json['division_id'];
    academicYearId = json['academic_year_id'];
    date = json['date'];
    presentCount = json['present_count'];
    absentCount = json['absent_count'];
  }
  num? id;
  num? userId;
  num? standardId;
  num? divisionId;
  num? academicYearId;
  String? date;
  num? presentCount;
  num? absentCount;
  AttendanceHistory copyWith({  num? id,
  num? userId,
  num? standardId,
  num? divisionId,
  num? academicYearId,
  String? date,
  num? presentCount,
  num? absentCount,
}) => AttendanceHistory(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  divisionId: divisionId ?? this.divisionId,
  academicYearId: academicYearId ?? this.academicYearId,
  date: date ?? this.date,
  presentCount: presentCount ?? this.presentCount,
  absentCount: absentCount ?? this.absentCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    map['division_id'] = divisionId;
    map['academic_year_id'] = academicYearId;
    map['date'] = date;
    map['present_count'] = presentCount;
    map['absent_count'] = absentCount;
    return map;
  }

}