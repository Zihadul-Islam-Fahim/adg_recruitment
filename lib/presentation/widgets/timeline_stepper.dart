import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/job_application_model.dart';
import '../../data/utils/statuls_to_label.dart';



import '../../data/models/applicationStatusModel.dart';


class TimelineStepper extends StatelessWidget {
  final JobApplication application;
  TimelineStepper({required this.application});

  final steps = [
    ApplicationStatus.applied,
    ApplicationStatus.under_review,
    ApplicationStatus.sent_to_company,
    ApplicationStatus.interview_invited,
    ApplicationStatus.interview_completed,
  ];

  @override
  Widget build(BuildContext context) {
    final current = labelToStatus(application.applicationStatus!);
    return Column(
      children: steps.map((s) {
        final done = _isAtOrAfter(current!, s);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              child: Column(
                children: [
                  CircleAvatar(radius: 10, backgroundColor: done ? Colors.indigo : Colors.grey[300], child: done ? Icon(Icons.check, size: 14, color: Colors.white) : SizedBox.shrink()),
                  Container(width: 2, height: 48, color: Colors.grey[300]),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(statusToLabel(s), style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  if (s == ApplicationStatus.interview_invited && application.interviewDate != null)
                    Text('Interview: ${DateFormat.yMMMd().add_jm().format(DateTime.parse(application.interviewDate!))}', style: TextStyle(color: Colors.grey[700])),
                ]),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  bool _isAtOrAfter(ApplicationStatus cur, ApplicationStatus s) {
    int idx(ApplicationStatus st) {
      switch (st) {
        case ApplicationStatus.applied:
          return 0;
        case ApplicationStatus.under_review:
          return 1;
        case ApplicationStatus.sent_to_company:
          return 2;
        case ApplicationStatus.interview_invited:
          return 3;
        case ApplicationStatus.interview_completed:
          return 4;

      }
    }

    return idx(cur) >= idx(s);
  }
}

