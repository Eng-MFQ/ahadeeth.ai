import 'package:flutter/material.dart';

import '../models/Fatwa.dart';

class FatwaCard extends StatelessWidget {
  final Fatwa fatwa;

  FatwaCard({required this.fatwa, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(fatwa.title, style: TextStyle(fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text(
              'السؤال: ${fatwa.question}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('الإجابة: ${fatwa.answer},', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('مأخوذ من فصل:  ${fatwa.chapter}'),
          ],
        ),
      ),
    );
  }
}
