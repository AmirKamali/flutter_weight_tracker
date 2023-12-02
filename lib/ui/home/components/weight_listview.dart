import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/date_helper.dart';
import '../../../providers/weight_provider.dart';
import '../../edit/edit_page.dart';

class WeightListView extends StatelessWidget {
  const WeightListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeightProvider>(
      builder: (context, weightProvider, child) {
        final weights = weightProvider.weights;
        if (weights.isEmpty) {
          return const Center(child: Text('No weight records found'));
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: weights.length,
          itemBuilder: (context, index) {
            final weightRecord = weights[index];
            return ListTile(
              title: Text('${weightRecord.weight} kg'),
              subtitle: Text(DateHelper.formatDate(weightRecord.timestamp)),
              trailing: Row(
                mainAxisSize:
                    MainAxisSize.min, // Ensure the row takes minimum space
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to the edit screen with the current weight record
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditScreen(weightRecord: weightRecord),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      weightProvider.deleteWeight(weightRecord.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
