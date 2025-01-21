import 'package:cloud_firestore/cloud_firestore.dart';

class Omikuji {
  final String id;
  final List<String> content;
  final int totalLines;
  final int creatorId;
  final int fortuneLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int selectedCount;  // 追加

  Omikuji({
    required this.id,
    required this.content,
    required this.totalLines,
    required this.creatorId,
    required this.fortuneLevel,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.selectedCount = 0,  // デフォルト値
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'totalLines': totalLines,
      'creatorId': creatorId,
      'fortuneLevel': fortuneLevel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'selectedCount': selectedCount,  // 追加
    };
  }

  factory Omikuji.fromMap(String id, Map<String, dynamic> map) {
    return Omikuji(
      id: id,
      content: List<String>.from(map['content']),
      totalLines: map['totalLines'],
      creatorId: map['creatorId'],
      fortuneLevel: map['fortuneLevel'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      isActive: map['isActive'],
      selectedCount: map['selectedCount'] ?? 0,  // 追加
    );
  }
}