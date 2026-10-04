  class LoginResponse {
  final bool? success;
  final UserData? data;
  final String? message;
  final String? lastPage;

  LoginResponse({
    this.success,
    this.data,
    this.message,
    this.lastPage,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      message: json['message'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'last_page': lastPage,
    };
  }
}

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final String? profileImage;
  final String? token;
  final School? school;

  UserData({
    this.id,
    this.name,
    this.email,
    this.role,
    this.profileImage,
    this.token,
    this.school,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      profileImage: json['profile_image'],
      token: json['token'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'profile_image': profileImage,
      'token': token,
      'school': school?.toJson(),
    };
  }
}

class School {
  final String? name;
  final String? profileImage;

  School({
    this.name,
    this.profileImage,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      name: json['name'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_image': profileImage,
    };
  }
}
