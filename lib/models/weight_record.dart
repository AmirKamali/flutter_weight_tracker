import 'package:cloud_firestore/cloud_firestore.dart';

class WeightRecord {
  final String id; // Add this line
  final double weight;
  final DateTime timestamp;

  WeightRecord({required this.id, required this.weight, required this.timestamp}); // Modify this line

  List<Object?> get props => [id, weight, timestamp]; // Modify this line

  factory WeightRecord.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return WeightRecord(
      id: doc.id, // Set the document ID
      weight: double.parse(data['weight'].toString()),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}