class TimetableModel {
  TimetableModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  TimetableModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TimeTableData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<TimeTableData>? data;
  String? message;
  String? lastPage;
TimetableModel copyWith({  bool? success,
  List<TimeTableData>? data,
  String? message,
  String? lastPage,
}) => TimetableModel(  success: success ?? this.success,
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

class TimeTableData {
  TimeTableData({
      this.day, 
      this.periods,});

  TimeTableData.fromJson(dynamic json) {
    day = json['day'];
    if (json['periods'] != null) {
      periods = [];
      json['periods'].forEach((v) {
        periods?.add(Periods.fromJson(v));
      });
    }
  }
  String? day;
  List<Periods>? periods;
  TimeTableData copyWith({  String? day,
  List<Periods>? periods,
}) => TimeTableData(  day: day ?? this.day,
  periods: periods ?? this.periods,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    if (periods != null) {
      map['periods'] = periods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Periods {
  Periods({
      this.day, 
      this.standardName, 
      this.divisionName, 
      this.subjectName, 
      this.startTime, 
      this.endTime,});

  Periods.fromJson(dynamic json) {
    day = json['day'];
    standardName = json['standard_name'];
    divisionName = json['division_name'];
    subjectName = json['subject_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  String? day;
  String? standardName;
  String? divisionName;
  String? subjectName;
  String? startTime;
  String? endTime;
Periods copyWith({  String? day,
  String? standardName,
  String? divisionName,
  String? subjectName,
  String? startTime,
  String? endTime,
}) => Periods(  day: day ?? this.day,
  standardName: standardName ?? this.standardName,
  divisionName: divisionName ?? this.divisionName,
  subjectName: subjectName ?? this.subjectName,
  startTime: startTime ?? this.startTime,
  endTime: endTime ?? this.endTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['standard_name'] = standardName;
    map['division_name'] = divisionName;
    map['subject_name'] = subjectName;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }

}