import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/applicationStatusModel.dart';
import '../../data/models/job_application_model.dart';
import '../../data/utils/statuls_to_label.dart';
import '../screen/application_details_screen.dart';

class ApplicationCard extends StatelessWidget {
  final JobApplication application;
  const ApplicationCard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final applied = DateFormat.yMMMd().format(DateTime.parse(application.createdAt ?? "") );

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Get.to(()=> ApplicationDetailScreen(jobApplication: application)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP ROW — TITLE + STATUS BADGE
            Row(
              children: [
                Expanded(
                  child: Text(
                    application.job?.jobTitle ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatusBadge(status: labelToStatus(application.applicationStatus!)!),
              ],
            ),

            const SizedBox(height: 6),

            /// COMPANY
            Text(
              application.job?.companyId ?? "",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),

            /// META INFO
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  "Applied $applied",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),

            /// INTERVIEW INFO
            if (application.applicationStatus == 'interview_invited' ) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.videocam, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Interview: ${DateFormat.yMMMd().add_jm().format(DateTime.parse(application.interviewDate!))}",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ApplicationStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (status) {
      case ApplicationStatus.applied:
      case ApplicationStatus.under_review:
        bg = Colors.blue.shade50;
        text = Colors.blue.shade700;
        break;

      case ApplicationStatus.sent_to_company:
        bg = Colors.purple.shade50;
        text = Colors.purple.shade700;
        break;

      case ApplicationStatus.interview_invited:
        bg = Colors.orange.shade50;
        text = Colors.orange.shade800;
        break;

      case ApplicationStatus.interview_completed:
        bg = Colors.teal.shade50;
        text = Colors.teal.shade700;
        break;


    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        statusToLabel(status),
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}


  IconData _statusIcon(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.applied:
      case ApplicationStatus.under_review:
        return Icons.receipt_long;
      case ApplicationStatus.sent_to_company:
        return Icons.send;
      case ApplicationStatus.interview_invited:
      case ApplicationStatus.interview_completed:
        return Icons.event;

    }
  }

  Color _statusColor(ApplicationStatus s) {
    switch (s) {

      case ApplicationStatus.interview_invited:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String _statusShort(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.applied:
        return 'Received';
      case ApplicationStatus.under_review:
        return 'Review';
      case ApplicationStatus.sent_to_company:
        return 'Sent';
      case ApplicationStatus.interview_invited:
        return 'Invite';
      case ApplicationStatus.interview_completed:
        return 'Done';

    }
  }
