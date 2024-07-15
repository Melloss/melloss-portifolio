// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FolderModel {
  final String name;
  FolderModel({
    required this.name,
  });

  FolderModel copyWith({
    String? name,
  }) {
    return FolderModel(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FolderModel.fromJson(String source) =>
      FolderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FolderModel(name: $name)';

  @override
  bool operator ==(covariant FolderModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
