import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/omikuji.dart';

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
}
