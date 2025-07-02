import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.name,
    required super.description,
    required super.imageUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'imageUrl': imageUrl};
  }
}
