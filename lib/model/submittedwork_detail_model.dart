class SubmittedHomeworkDetailModel {
  SubmittedHomeworkDetailModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  SubmittedHomeworkDetailModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  Data? data;
  String? message;
  String? lastPage;
  SubmittedHomeworkDetailModel copyWith({  bool? success,
  Data? data,
  String? message,
  String? lastPage,
}) => SubmittedHomeworkDetailModel(  success: success ?? this.success,
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

class Data {
  Data({
      this.id, 
      this.homeworkId, 
      this.userId, 
      this.answer, 
      this.submittedAt, 
      this.checkedAt, 
      this.status, 
      this.comment, 
      this.student, 
      this.audioUrl, 
      this.images, 
      this.homework,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    homeworkId = json['homework_id'];
    userId = json['user_id'];
    answer = json['answer'];
    submittedAt = json['submitted_at'];
    checkedAt = json['checked_at'];
    status = json['status'];
    comment = json['comment'];
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    audioUrl = json['audio_url'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    homework = json['homework'] != null ? Homework.fromJson(json['homework']) : null;
  }
  num? id;
  num? homeworkId;
  num? userId;
  String? answer;
  String? submittedAt;
  String? checkedAt;
  String? status;
  String? comment;
  Student? student;
  String? audioUrl;
  List<Images>? images;
  Homework? homework;
Data copyWith({  num? id,
  num? homeworkId,
  num? userId,
  String? answer,
  String? submittedAt,
  String? checkedAt,
  String? status,
  String? comment,
  Student? student,
  String? audioUrl,
  List<Images>? images,
  Homework? homework,
}) => Data(  id: id ?? this.id,
  homeworkId: homeworkId ?? this.homeworkId,
  userId: userId ?? this.userId,
  answer: answer ?? this.answer,
  submittedAt: submittedAt ?? this.submittedAt,
  checkedAt: checkedAt ?? this.checkedAt,
  status: status ?? this.status,
  comment: comment ?? this.comment,
  student: student ?? this.student,
  audioUrl: audioUrl ?? this.audioUrl,
  images: images ?? this.images,
  homework: homework ?? this.homework,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['homework_id'] = homeworkId;
    map['user_id'] = userId;
    map['answer'] = answer;
    map['submitted_at'] = submittedAt;
    map['checked_at'] = checkedAt;
    map['status'] = status;
    map['comment'] = comment;
    if (student != null) {
      map['student'] = student?.toJson();
    }
    map['audio_url'] = audioUrl;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (homework != null) {
      map['homework'] = homework?.toJson();
    }
    return map;
  }

}

class Homework {
  Homework({
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

  Homework.fromJson(dynamic json) {
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
Homework copyWith({  num? id,
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
}) => Homework(  id: id ?? this.id,
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

class Images {
  Images({
      this.filePath,});

  Images.fromJson(dynamic json) {
    filePath = json['file_path'];
  }
  String? filePath;
Images copyWith({  String? filePath,
}) => Images(  filePath: filePath ?? this.filePath,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file_path'] = filePath;
    return map;
  }

}

class Student {
  Student({
      this.id, 
      this.grNumber, 
      this.name, 
      this.profileImage, 
      this.rollNumber,});

  Student.fromJson(dynamic json) {
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
Student copyWith({  num? id,
  String? grNumber,
  String? name,
  String? profileImage,
  String? rollNumber,
}) => Student(  id: id ?? this.id,
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