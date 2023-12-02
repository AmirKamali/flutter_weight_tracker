import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/helpers/date_helper.dart';
import '../../providers/weight_provider.dart';
import 'components/weight_chart.dart';
import 'components/weight_listview.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final User? currentUser =
      FirebaseAuth.instance.currentUser; // Retrieve current user
  DateTime selectedDate = DateTime.now(); // Default is today

  HomePage({super.key});

  // Screen title
  String appBarTitle() {
    String title = "Welcome"; // Default title
    if (currentUser != null) {
      if (currentUser!.isAnonymous) {
        title = "Welcome Anonymous";
      } else if (currentUser!.displayName != null &&
          currentUser!.displayName!.isNotEmpty) {
        title = "Welcome ${currentUser!.displayName!}";
      }
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    // Weight records
    final weightProvider = Provider.of<WeightProvider>(context);
    weightProvider.loadWeights();

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            weightProvider.weights.isNotEmpty
                ? WeightChart(weightRecords: weightProvider.weights)
                : const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No weight data available."),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Enter your weight',
                  suffix: Text('kg'),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal numbers
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d*')), // Allow digits and a single decimal point
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Today',
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                try {
                  final weight = double.parse(_weightController.text.trim());
                  if (weight > 0) {
                    weightProvider.addWeight(weight, selectedDate);
                    _weightController.clear();
                  }
                } catch (ex) {
                  if (kDebugMode) {
                    print("add failed");
                  }
                }
              },
            ),
            const WeightListView(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _dateController.text = DateHelper.formatDate(selectedDate);
    }
  }
}
