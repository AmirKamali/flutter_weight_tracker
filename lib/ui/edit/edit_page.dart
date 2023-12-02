import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/weight_record.dart';
import '../../providers/weight_provider.dart';

class EditScreen extends StatelessWidget {
  final WeightRecord weightRecord;
  final TextEditingController _weightController = TextEditingController();

  EditScreen({Key? key, required this.weightRecord}) : super(key: key) {
    _weightController.text =
        weightRecord.weight.toString(); // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    final weightProvider = Provider.of<WeightProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Weight'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Edit your weight',
                suffix: Text('kg'),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: const Text('Save Changes'),
              onPressed: () {
                try {
                  final newWeight = double.parse(_weightController.text.trim());
                  if (newWeight > 0) {
                    weightProvider.updateWeight(weightRecord.id, newWeight);
                    Navigator.pop(context); // Go back after updating
                  }
                } catch (ex) {
                  // Handle exceptions
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
