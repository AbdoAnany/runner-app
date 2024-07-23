import 'package:flutter/material.dart';

class HistorySection extends StatelessWidget {
  final List<Map<String, dynamic>> runnerData;

  HistorySection({required this.runnerData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 10),
        runnerData.isEmpty
            ? Center(child: Text('No history available.'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: runnerData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.history),
                    title: Text(runnerData[index]['name']),
                    subtitle: Text('Time: ${runnerData[index]['time']}'),
                  );
                },
              ),
      ],
    );
  }
}
