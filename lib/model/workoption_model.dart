class WorkOptionModel {
  final bool? success;
  final List<WorkOption> data;
  final String? message;

  const WorkOptionModel({
    this.success,
    this.data = const [],
    this.message,
  });

  factory WorkOptionModel.fromJson(Map<String, dynamic> json) {
    return WorkOptionModel(
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: (json['data'] as List<dynamic>? ?? [])
          .map(
            (item) => WorkOption.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      )
          .toList(),
    );
  }
}

class WorkOption {
  final int id;
  final String name;

  const WorkOption({
    required this.id,
    required this.name,
  });

  factory WorkOption.fromJson(Map<String, dynamic> json) {
    return WorkOption(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString() ?? '',
    );
  }
}