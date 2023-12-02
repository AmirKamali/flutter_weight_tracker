import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/weight_record.dart';
import 'abstract/remote_storage_service.dart';

class FirestoreService implements RemoteStorageService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<WeightRecord>> getWeightRecords() async {
    var snapshot = await firestore.collection('weights').orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => WeightRecord.fromFirestore(doc)).toList();
  }

  @override
  Future<String> addWeightRecord(Map<String, dynamic> data) async {
    var docRef = await firestore.collection('weights').add(data);
    return docRef.id;
  }

  @override
  Future<void> deleteWeightRecord(String documentId) {
    return firestore.collection('weights').doc(documentId).delete();
  }

  @override
  Future<void> updateWeightRecord(String id, Map<String, dynamic> data) {
    return firestore.collection('weights').doc(id).update(data);
  }
}