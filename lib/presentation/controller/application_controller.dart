import 'package:get/get.dart';

import '../../data/models/job_application_model.dart';
class AppController extends GetxController {
  // simple in-memory list (replace with API calls)
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

  // update status and call update() so GetBuilder rebuilds widgets that listen
  void updateStatus(String id, ApplicationStatus newStatus) {
    final idx = apps.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      apps[idx].status = newStatus;
      update(); // <-- GetBuilder will react
    }
  }

  JobApplication? findById(String id) => FirstWhereExt(apps).firstWhereOrNull((a) => a.id == id);

  // helper to simulate scheduling an interview
  void scheduleInterview(String id, DateTime dateTime) {
    final idx = apps.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      apps[idx].status = ApplicationStatus.interviewInvited;
      apps[idx].interviewAt = dateTime;
      update();
    }
  }

// add/remove document stubs (not implemented)...
}

/// Extension: firstWhereOrNull helper (since dart:core doesn't have it pre null-safety helper)
extension FirstWhereOrNull<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (var e in this) if (test(e)) return e;
    return null;
  }
}
