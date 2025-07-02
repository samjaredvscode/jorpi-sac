
import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String name;
  final String description;
  final String imageUrl;

  const Project({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, description, imageUrl];
}
