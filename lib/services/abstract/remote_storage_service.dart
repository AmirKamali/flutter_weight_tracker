import '../../models/weight_record.dart';

abstract class RemoteStorageService {
  Future<List<WeightRecord>> getWeightRecords();
  Future<String> addWeightRecord(Map<String, dynamic> data);
  Future<void> deleteWeightRecord(String documentId);
  Future<void> updateWeightRecord(String id, Map<String, dynamic> data);
}