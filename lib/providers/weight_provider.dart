import 'package:flutter/foundation.dart';
import '../models/weight_record.dart';
import '../services/abstract/remote_storage_service.dart';

class WeightProvider with ChangeNotifier {
  final List<WeightRecord> _weights = [];
  final RemoteStorageService remoteStorageService;

  WeightProvider({required this.remoteStorageService});

  List<WeightRecord> get weights => List.unmodifiable(_weights);

  // Load List of records
  Future<void> loadWeights() async {
    try { 
      var weightRecords = await remoteStorageService.getWeightRecords();

      _weights.clear();
      _weights.addAll(weightRecords);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading weights: $e');
      }
    }
  }

  // Add weight
  Future<void> addWeight(double weight, DateTime date) async {
    try {
      DateTime currentTime = DateTime.now();
      DateTime combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        currentTime.hour,
        currentTime.minute,
        currentTime.second,
        currentTime.millisecond,
      );

      String docId = await remoteStorageService.addWeightRecord({
        'weight': weight,
        'timestamp': combinedDateTime,
      });

      _weights.insert(
        0,
        WeightRecord(
          id: docId,
          weight: weight,
          timestamp: combinedDateTime,
        ),
      );
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding weight: $e');
      }
    }
  }

  // Remove Record
  Future<void> deleteWeight(String documentId) async {
    try {
      await remoteStorageService.deleteWeightRecord(documentId);
      _weights.removeWhere((record) => record.id == documentId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting weight: $e');
      }
    }
  }

  // Update Record
  Future<void> updateWeight(String id, double newWeight) async {
    try {
      await remoteStorageService.updateWeightRecord(id, {'weight': newWeight});

      int indexToUpdate = _weights.indexWhere((record) => record.id == id);
      if (indexToUpdate != -1) {
        _weights[indexToUpdate] = WeightRecord(
          id: id,
          weight: newWeight,
          timestamp: _weights[indexToUpdate].timestamp,
        );
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating weight: $e');
      }
    }
  }
}
