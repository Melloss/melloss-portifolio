// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TerminalModel {
  final List<String> path;
  final String? initialText;
  TerminalModel({
    required this.path,
    this.initialText,
  });

  TerminalModel copyWith({
    List<String>? path,
    String? initialText,
  }) {
    return TerminalModel(
      path: path ?? this.path,
      initialText: initialText ?? this.initialText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'initialText': initialText,
    };
  }

  factory TerminalModel.fromMap(Map<String, dynamic> map) {
    return TerminalModel(
      path: List<String>.from((map['path'] as List<String>)),
      initialText:
          map['initialText'] != null ? map['initialText'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TerminalModel.fromJson(String source) =>
      TerminalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TerminalModel(path: $path, initialText: $initialText)';

  @override
  bool operator ==(covariant TerminalModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.path, path) && other.initialText == initialText;
  }

  @override
  int get hashCode => path.hashCode ^ initialText.hashCode;
}
