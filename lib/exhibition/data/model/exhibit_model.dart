import 'dart:convert';

import 'package:equatable/equatable.dart';

class Exhibit extends Equatable {
  String title;
  List<String> images;
  Exhibit({
    required this.title,
    required this.images,
  });

  @override
  List<Object> get props => [title, images];

  Exhibit copyWith({
    String? title,
    List<String>? images,
  }) {
    return Exhibit(
      title: title ?? this.title,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'images': images,
    };
  }

  factory Exhibit.fromMap(Map<String, dynamic> map) {
    return Exhibit(
      title: map['title'] ?? '',
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Exhibit.fromJson(String source) =>
      Exhibit.fromMap(json.decode(source));

  @override
  String toString() => 'Exhibit(title: $title, images: $images)';
}
