// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BrowserTabModel extends Equatable {
  final int id;
  final String url;
  final String title;
  BrowserTabModel({
    required this.id,
    required this.url,
    required this.title,
  });

  BrowserTabModel copyWith({
    int? id,
    String? url,
    String? title,
  }) {
    return BrowserTabModel(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
    };
  }

  factory BrowserTabModel.fromMap(Map<String, dynamic> map) {
    return BrowserTabModel(
      id: map['id'] as int,
      url: map['url'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrowserTabModel.fromJson(String source) =>
      BrowserTabModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BrowserTabModel(id: $id, url: $url, title: $title)';

  @override
  bool operator ==(covariant BrowserTabModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.url == url && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ url.hashCode ^ title.hashCode;

  @override
  List<Object?> get props => [
        id,
        url,
        title,
      ];
}
