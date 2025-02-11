import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // デバッグ機能に関するパケージ
import 'omikuji.dart';

class OmikujiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'omikuji';

  // おみくじ一覧の取得
  Stream<List<Omikuji>> getOmikujiList() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Omikuji.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // 作成者ID一覧の取得
  Stream<List<String>> getUniqueCreatorIds() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      final ids = snapshot.docs
          .map((doc) => doc.data()['creatorId'].toString())
          .toSet() // 重複を除去
          .toList();
      ids.sort(); // IDを昇順にソート
      return ids;
    });
  }

  // キーワードによる検索
  Stream<List<Omikuji>> searchOmikuji(String keyword) {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final allOmikuji = snapshot.docs
          .map((doc) => Omikuji.fromMap(doc.id, doc.data()))
          .toList();

      if (keyword.isEmpty) return allOmikuji;

      return allOmikuji
          .where((omikuji) =>
              omikuji.content.any((line) => line.contains(keyword)))
          .toList();
    });
  }

  // おみくじの追加
  Future<void> addOmikuji(
      List<String> content, int creatorId, int fortuneLevel) async {
    final now = DateTime.now();
    await _firestore.collection(_collection).add({
      'content': content,
      'totalLines': content.length,
      'creatorId': creatorId,
      'fortuneLevel': fortuneLevel,
      'createdAt': now,
      'updatedAt': now,
      'isActive': true,
    });
  }

  // おみくじの更新
  Future<void> updateOmikuji(
      String id, List<String> content, int fortuneLevel, int creatorId) async {
    await _firestore.collection(_collection).doc(id).update({
      'content': content,
      'totalLines': content.length,
      'fortuneLevel': fortuneLevel,
      'creatorId': creatorId,
      'updatedAt': DateTime.now(),
    });
  }

  // おみくじの削除（論理削除）
  Future<void> deactivateOmikuji(String id) async {
    await _firestore.collection(_collection).doc(id).update({
      'isActive': false,
      'updatedAt': DateTime.now(),
    });
  }

  // おみくじの完全削除
  Future<void> deleteOmikuji(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  // おみくじの選択回数を増やす
  Future<void> incrementSelectedCount(String id) async {
    await _firestore.collection(_collection).doc(id).update({
      'selectedCount': FieldValue.increment(1),
      'updatedAt': DateTime.now(),
    });
  }

  // おみくじ選択のためのタイミング計算（新規追加）
  int _calculateSelectionValue(DateTime startTime) {
    final now = DateTime.now();
    final elapsedMilliseconds = now.difference(startTime).inMilliseconds;
    final microseconds = now.microsecond;

    if (kDebugMode) {
      print('経過ミリ秒: $elapsedMilliseconds');
      print('現在のマイクロ秒: $microseconds');
      print('合計値: ${elapsedMilliseconds + microseconds}');
    }

    return elapsedMilliseconds + microseconds;
  }

  // おみくじ選択の実装（新規追加）
  Future<Map<String, dynamic>> selectOmikujiByTiming(DateTime startTime) async {
    try {
      // データ取得
      final snapshot = await _firestore
          .collection(_collection)
          .where('isActive', isEqualTo: true)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('おみくじがありません');
      }

      // タイミングに基づく選択
      final selectionValue = _calculateSelectionValue(startTime);
      final selectedIndex = selectionValue % snapshot.docs.length;

      if (kDebugMode) {
        print('おみくじ総数: ${snapshot.docs.length}');
        print('選択された番号: $selectedIndex');
      }

      final selectedDoc = snapshot.docs[selectedIndex];

      // 選択回数を更新
      await incrementSelectedCount(selectedDoc.id);

      return {
        'id': selectedDoc.id,
        'data': selectedDoc.data(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('おみくじ選択エラー: $e');
      }
      throw Exception('おみくじの選択に失敗しました: $e');
    }
  }
}
