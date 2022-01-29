import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/season/season.dart';
import 'package:pick/segment/segment.dart';

class SegmentsFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('segments');

  Future<List<Segment>> fetchSegments() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Segment.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }

  Future<List<Segment>> fetchSegmentsBySeason({required Season season}) async {
    var result =
        await collection.where('seasonReference', isEqualTo: season.id).get();

    return result.docs
        .map(
          (doc) => Segment.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }
}
