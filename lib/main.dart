import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weight_provider.dart';
import 'services/firestore_storage_service.dart';
import 'ui/sign_in/authentication_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WeightTrackerApp());
}

class WeightTrackerApp extends StatelessWidget {
  const WeightTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WeightProvider(remoteStorageService: FirestoreService()),
        child: const MaterialApp(
          title: 'Weight Tracker',
          home: AuthenticationWrapper(),
        ));
  }
}

