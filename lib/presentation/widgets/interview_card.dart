import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterviewCard extends StatelessWidget {
  final DateTime interviewAt;

  const InterviewCard({required this.interviewAt});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat.yMMMMd().add_jm();
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.event),
            SizedBox(width: 8),
            Text('Interview scheduled',
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          SizedBox(height: 8),
          Text(f.format(interviewAt)),
          SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            ElevatedButton.icon(onPressed: () {
              /* add to calendar */
            },
                icon: Icon(Icons.calendar_today),
                label: Text('Add to calendar')),
            OutlinedButton.icon(onPressed: () {
              /* join */
            }, icon: Icon(Icons.videocam), label: Text('Join meeting')),
          ]),
        ]),
      ),
    );
  }
}