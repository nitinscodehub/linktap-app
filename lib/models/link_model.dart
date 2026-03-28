import 'dart:convert';

class LinkModel {
  final String id;
  final String name;
  final String url;
  final DateTime createdAt;

  LinkModel({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
  });

  // Create LinkModel from JSON map
  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Convert LinkModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a copy with updated fields
  LinkModel copyWith({
    String? id,
    String? name,
    String? url,
    DateTime? createdAt,
  }) {
    return LinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Encode list of links to JSON string
  static String encodeList(List<LinkModel> links) {
    return jsonEncode(links.map((link) => link.toJson()).toList());
  }

  // Decode JSON string to list of links
  static List<LinkModel> decodeList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => LinkModel.fromJson(json)).toList();
  }
}
