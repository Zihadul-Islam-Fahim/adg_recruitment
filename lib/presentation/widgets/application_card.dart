import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/job_application_model.dart';
import '../../data/utils/statuls_to_label.dart';
import '../screen/application_details_screen.dart';

class ApplicationCard extends StatelessWidget {
  final JobApplication application;
  const ApplicationCard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final applied = DateFormat.yMMMd().format(application.appliedAt);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Get.toNamed('/detail/${application.id}'),
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
                    application.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatusBadge(status: application.status),
              ],
            ),

            const SizedBox(height: 6),

            /// COMPANY
            Text(
              application.company,
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
            if (application.status == ApplicationStatus.interviewInvited &&
                application.interviewAt != null) ...[
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
                        "Interview: ${DateFormat.yMMMd().add_jm().format(application.interviewAt!)}",
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
      case ApplicationStatus.resumeReceived:
      case ApplicationStatus.underReview:
        bg = Colors.blue.shade50;
        text = Colors.blue.shade700;
        break;

      case ApplicationStatus.sentToClient:
        bg = Colors.purple.shade50;
        text = Colors.purple.shade700;
        break;

      case ApplicationStatus.interviewInvited:
        bg = Colors.orange.shade50;
        text = Colors.orange.shade800;
        break;

      case ApplicationStatus.interviewDone:
        bg = Colors.teal.shade50;
        text = Colors.teal.shade700;
        break;

      case ApplicationStatus.offer:
        bg = Colors.green.shade50;
        text = Colors.green.shade700;
        break;

      case ApplicationStatus.rejection:
        bg = Colors.red.shade50;
        text = Colors.red.shade700;
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
      case ApplicationStatus.resumeReceived:
      case ApplicationStatus.underReview:
        return Icons.receipt_long;
      case ApplicationStatus.sentToClient:
        return Icons.send;
      case ApplicationStatus.interviewInvited:
      case ApplicationStatus.interviewDone:
        return Icons.event;
      case ApplicationStatus.offer:
        return Icons.thumb_up;
      case ApplicationStatus.rejection:
        return Icons.close;
    }
  }

  Color _statusColor(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.offer:
        return Colors.green;
      case ApplicationStatus.rejection:
        return Colors.red;
      case ApplicationStatus.interviewInvited:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String _statusShort(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.resumeReceived:
        return 'Received';
      case ApplicationStatus.underReview:
        return 'Review';
      case ApplicationStatus.sentToClient:
        return 'Sent';
      case ApplicationStatus.interviewInvited:
        return 'Invite';
      case ApplicationStatus.interviewDone:
        return 'Done';
      case ApplicationStatus.offer:
        return 'Offer';
      case ApplicationStatus.rejection:
        return 'Rejected';
    }
  }
