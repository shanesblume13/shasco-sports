import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SeasonApiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> ref;

  SeasonApiService() {
    ref = _db.collection('seasons');
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, dynamic> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, Object?> data, String id) {
    return ref.doc(id).update(data);
  }
}
