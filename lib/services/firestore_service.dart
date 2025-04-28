import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addFavorite(String userId, Map<String, dynamic> charData) {
    final docId = charData['id'].toString();
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(docId)
        .set(charData);
  }

  Future<void> removeFavorite(String userId, String charId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(charId)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> favoritesStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  Future<bool> isFavorite(String userId, String charId) async {
    final doc =
        await _db
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(charId)
            .get();
    return doc.exists;
  }
}
