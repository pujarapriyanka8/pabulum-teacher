class HomeworkDetailModel {
  HomeworkDetailModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  HomeworkDetailModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? HomeworkDetailData.fromJson(json['data']) : null;
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  HomeworkDetailData? data;
  String? message;
  String? lastPage;
HomeworkDetailModel copyWith({  bool? success,
  HomeworkDetailData? data,
  String? message,
  String? lastPage,
}) => HomeworkDetailModel(  success: success ?? this.success,
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

class HomeworkDetailData {
  HomeworkDetailData({
      this.id, 
      this.userId, 
      this.standardId, 
      this.divisionId, 
      this.subjectId, 
      this.lessonId, 
      this.topicId, 
      this.standard, 
      this.division, 
      this.subject, 
      this.lesson, 
      this.topic, 
      this.title, 
      this.text, 
      this.startDate, 
      this.dueDate, 
      this.imageUrl, 
      this.pdfUrl, 
      this.audioUrl, 
      this.videoUrl, 
      this.youtubeUrl,});

  HomeworkDetailData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    standardId = json['standard_id'];
    divisionId = json['division_id'];
    subjectId = json['subject_id'];
    lessonId = json['lesson_id'];
    topicId = json['topic_id'];
    standard = json['standard'] != null ? Standard.fromJson(json['standard']) : null;
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    lesson = json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    title = json['title'];
    text = json['text'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    imageUrl = json['image_url'];
    pdfUrl = json['pdf_url'];
    audioUrl = json['audio_url'];
    videoUrl = json['video_url'];
    youtubeUrl = json['youtube_url'];
  }
  num? id;
  num? userId;
  num? standardId;
  num? divisionId;
  num? subjectId;
  num? lessonId;
  num? topicId;
  Standard? standard;
  Division? division;
  Subject? subject;
  Lesson? lesson;
  Topic? topic;
  String? title;
  String? text;
  String? startDate;
  String? dueDate;
  dynamic imageUrl;
  dynamic pdfUrl;
  dynamic audioUrl;
  dynamic videoUrl;
  dynamic youtubeUrl;
  HomeworkDetailData copyWith({  num? id,
  num? userId,
  num? standardId,
  num? divisionId,
  num? subjectId,
  num? lessonId,
  num? topicId,
  Standard? standard,
  Division? division,
  Subject? subject,
  Lesson? lesson,
  Topic? topic,
  String? title,
  String? text,
  String? startDate,
  String? dueDate,
  dynamic imageUrl,
  dynamic pdfUrl,
  dynamic audioUrl,
  dynamic videoUrl,
  dynamic youtubeUrl,
}) => HomeworkDetailData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  standardId: standardId ?? this.standardId,
  divisionId: divisionId ?? this.divisionId,
  subjectId: subjectId ?? this.subjectId,
  lessonId: lessonId ?? this.lessonId,
  topicId: topicId ?? this.topicId,
  standard: standard ?? this.standard,
  division: division ?? this.division,
  subject: subject ?? this.subject,
  lesson: lesson ?? this.lesson,
  topic: topic ?? this.topic,
  title: title ?? this.title,
  text: text ?? this.text,
  startDate: startDate ?? this.startDate,
  dueDate: dueDate ?? this.dueDate,
  imageUrl: imageUrl ?? this.imageUrl,
  pdfUrl: pdfUrl ?? this.pdfUrl,
  audioUrl: audioUrl ?? this.audioUrl,
  videoUrl: videoUrl ?? this.videoUrl,
  youtubeUrl: youtubeUrl ?? this.youtubeUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['standard_id'] = standardId;
    map['division_id'] = divisionId;
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
    map['text'] = text;
    map['start_date'] = startDate;
    map['due_date'] = dueDate;
    map['image_url'] = imageUrl;
    map['pdf_url'] = pdfUrl;
    map['audio_url'] = audioUrl;
    map['video_url'] = videoUrl;
    map['youtube_url'] = youtubeUrl;
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

