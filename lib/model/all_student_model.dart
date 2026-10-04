class AllStudentModel {
  AllStudentModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  AllStudentModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AllStudentData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<AllStudentData>? data;
  String? message;
  String? lastPage;
AllStudentModel copyWith({  bool? success,
  List<AllStudentData>? data,
  String? message,
  String? lastPage,
}) => AllStudentModel(  success: success ?? this.success,
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

class AllStudentData {
  AllStudentData({
      this.id, 
      this.grNumber, 
      this.name, 
      this.profileImage, 
      this.rollNumber,});

  AllStudentData.fromJson(dynamic json) {
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
  AllStudentData copyWith({  num? id,
  String? grNumber,
  String? name,
  String? profileImage,
  String? rollNumber,
}) => AllStudentData(  id: id ?? this.id,
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