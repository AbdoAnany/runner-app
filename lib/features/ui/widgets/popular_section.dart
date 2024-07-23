import 'package:flutter/material.dart';

class PopularSection extends StatelessWidget {
  final List<Map<String, dynamic>> popularData;

  PopularSection({required this.popularData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 10),
        popularData.isEmpty
            ? Center(child: Text('No popular data available.'))
            : ListView.builder(
          shrinkWrap: true,
          itemCount: popularData.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.trending_up),
              title: Text(popularData[index]['name']),
              subtitle: Text('Time: ${popularData[index]['time']}'),
            );
          },
        ),
      ],
    );
  }
}
