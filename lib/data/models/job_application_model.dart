import 'package:flutter/foundation.dart';
enum ApplicationStatus {
  resumeReceived,
  underReview,
  sentToClient,
  interviewInvited,
  interviewDone,
  offer,
  rejection,
}

class JobApplication {
  final String id;
  final String title;
  final String company;
  final DateTime appliedAt;
  ApplicationStatus status;
  DateTime? interviewAt;

  JobApplication({
    required this.id,
    required this.title,
    required this.company,
    required this.appliedAt,
    required this.status,
    this.interviewAt,
  });
}

// --- Mock repository (simple provider) ---
class AppState extends ChangeNotifier {
  List<JobApplication> apps = [
    JobApplication(
      id: 'a1',
      title: 'Software Engineer',
      company: 'ABC Tech',
      appliedAt: DateTime.now().subtract(Duration(days: 10)),
      status: ApplicationStatus.sentToClient,
    ),
    JobApplication(
      id: 'a2',
      title: 'Product Manager',
      company: 'Global Inc.',
      appliedAt: DateTime.now().subtract(Duration(days: 3)),
      status: ApplicationStatus.interviewInvited,
      interviewAt: DateTime.now().add(Duration(days: 2, hours: 14)),
    ),
    JobApplication(
      id: 'a3',
      title: 'Data Analyst',
      company: 'Insights LLC',
      appliedAt: DateTime.now().subtract(Duration(days: 1)),
      status: ApplicationStatus.underReview,
    ),
  ];

  void updateStatus(String id, ApplicationStatus newStatus) {
    final idx = apps.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      apps[idx].status = newStatus;
      notifyListeners();
    }
  }
}