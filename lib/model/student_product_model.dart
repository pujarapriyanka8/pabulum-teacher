class StudentProductModel {
  StudentProductModel({
      this.success, 
      this.data, 
      this.message, 
      this.lastPage,});

  StudentProductModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StudentProductData.fromJson(v));
      });
    }
    message = json['message'];
    lastPage = json['last_page'];
  }
  bool? success;
  List<StudentProductData>? data;
  String? message;
  num? lastPage;
StudentProductModel copyWith({  bool? success,
  List<StudentProductData>? data,
  String? message,
  num? lastPage,
}) => StudentProductModel(  success: success ?? this.success,
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

class StudentProductData {
  StudentProductData({
      this.id, 
      this.userId, 
      this.productId, 
      this.requestedAt, 
      this.deliveredAt, 
      this.status, 
      this.student, 
      this.product,});

  StudentProductData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    requestedAt = json['requested_at'];
    deliveredAt = json['delivered_at'];
    status = json['status'];
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  num? id;
  num? userId;
  num? productId;
  String? requestedAt;
  String? deliveredAt;
  String? status;
  Student? student;
  Product? product;
  StudentProductData copyWith({  num? id,
  num? userId,
  num? productId,
  String? requestedAt,
  String? deliveredAt,
  String? status,
  Student? student,
  Product? product,
}) => StudentProductData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  productId: productId ?? this.productId,
  requestedAt: requestedAt ?? this.requestedAt,
  deliveredAt: deliveredAt ?? this.deliveredAt,
  status: status ?? this.status,
  student: student ?? this.student,
  product: product ?? this.product,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['requested_at'] = requestedAt;
    map['delivered_at'] = deliveredAt;
    map['status'] = status;
    if (student != null) {
      map['student'] = student?.toJson();
    }
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

}

class Product {
  Product({
      this.id, 
      this.userId, 
      this.categoryId, 
      this.name, 
      this.price, 
      this.image, 
      this.description,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
  }
  num? id;
  num? userId;
  num? categoryId;
  String? name;
  String? price;
  String? image;
  dynamic description;
Product copyWith({  num? id,
  num? userId,
  num? categoryId,
  String? name,
  String? price,
  String? image,
  dynamic description,
}) => Product(  id: id ?? this.id,
  userId: userId ?? this.userId,
  categoryId: categoryId ?? this.categoryId,
  name: name ?? this.name,
  price: price ?? this.price,
  image: image ?? this.image,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['price'] = price;
    map['image'] = image;
    map['description'] = description;
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