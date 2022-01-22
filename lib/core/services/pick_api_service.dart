import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class PickApiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> ref;

  PickApiService() {
    ref = _db.collection('picks');
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
