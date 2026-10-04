class HomeworkModel {
  HomeworkModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  HomeworkModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(HomeWorkData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<HomeWorkData>? data;
  String? message;
  num? lastPage;
HomeworkModel copyWith({  bool? success,
  List<HomeWorkData>? data,
  String? message,
  num? lastPage,
}) => HomeworkModel(  success: success ?? this.success,
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

class HomeWorkData {
  HomeWorkData({
      this.id, 
      this.userId, 
      this.standardId, 
      this.subjectId, 
      this.lessonId, 
      this.topicId, 
      this.standard, 
      this.division, 
      this.subject, 
      this.lesson, 
      this.topic, 
      this.title, 
      this.startDate, 
      this.dueDate,});

  HomeWorkData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    subjectId = json['subject_id'];
    lessonId = json['lesson_id'];
    topicId = json['topic_id'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    lesson = json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    title = json['title'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
  }
  num? id;
  num? userId;
  num? standardId;
  num? subjectId;
  num? lessonId;
  num? topicId;
  Standard? standard;
  Division? division;
  Subject? subject;
  Lesson? lesson;
  Topic? topic;
  String? title;
  String? startDate;
  String? dueDate;
  HomeWorkData copyWith({  num? id,
  num? userId,
  num? standardId,
  num? subjectId,
  num? lessonId,
  num? topicId,
  Standard? standard,
  Division? division,
  Subject? subject,
  Lesson? lesson,
  Topic? topic,
  String? title,
  String? startDate,
  String? dueDate,
}) => HomeWorkData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  subjectId: subjectId ?? this.subjectId,
  lessonId: lessonId ?? this.lessonId,
  topicId: topicId ?? this.topicId,
  standard: standard ?? this.standard,
  division: division ?? this.division,
  subject: subject ?? this.subject,
  lesson: lesson ?? this.lesson,
  topic: topic ?? this.topic,
  title: title ?? this.title,
  startDate: startDate ?? this.startDate,
  dueDate: dueDate ?? this.dueDate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    map['subject_id'] = subjectId;
    map['lesson_id'] = lessonId;
    map['topic_id'] = topicId;
    if (standard != null) {
      map['standard'] = standard?.toJson();
    }
    if (division != null) {
      map['division'] = division?.toJson();
    }
    if (subject != null) {
      map['subject'] = subject?.toJson();
    }
    if (lesson != null) {
      map['lesson'] = lesson?.toJson();
    }
    if (topic != null) {
      map['topic'] = topic?.toJson();
    }
    map['title'] = title;
    map['start_date'] = startDate;
    map['due_date'] = dueDate;
    return map;
  }

}

class Topic {
  Topic({
      this.id, 
      this.name, 
      this.standardId, 
      this.subjectId, 
      this.lessonId,});

  Topic.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    standardId = json['standard_id'];
    subjectId = json['subject_id'];
    lessonId = json['lesson_id'];
  }
  num? id;
  String? name;
  num? standardId;
  num? subjectId;
  num? lessonId;
Topic copyWith({  num? id,
  String? name,
  num? standardId,
  num? subjectId,
  num? lessonId,
}) => Topic(  id: id ?? this.id,
  name: name ?? this.name,
  standardId: standardId ?? this.standardId,
  subjectId: subjectId ?? this.subjectId,
  lessonId: lessonId ?? this.lessonId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['standard_id'] = standardId;
    map['subject_id'] = subjectId;
    map['lesson_id'] = lessonId;
    return map;
  }

}

class Lesson {
  Lesson({
      this.id, 
      this.name, 
      this.standardId, 
      this.subjectId,});

  Lesson.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    standardId = json['standard_id'];
    subjectId = json['subject_id'];
  }
  num? id;
  String? name;
  num? standardId;
  num? subjectId;
Lesson copyWith({  num? id,
  String? name,
  num? standardId,
  num? subjectId,
}) => Lesson(  id: id ?? this.id,
  name: name ?? this.name,
  standardId: standardId ?? this.standardId,
  subjectId: subjectId ?? this.subjectId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['standard_id'] = standardId;
    map['subject_id'] = subjectId;
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


