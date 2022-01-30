import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirestoreApiService {
  FirestoreApiService(
    this.collectionName,
  ) {
    ref = _db.collection(collectionName);
  }

  final String collectionName;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> ref;

  Future<QuerySnapshot<Map<String, dynamic>>> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(DocumentReference reference) {
    return ref.doc(reference.id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, dynamic> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(
      Map<String, Object?> data, DocumentReference reference) {
    return ref.doc(reference.id).update(data);
  }
}
