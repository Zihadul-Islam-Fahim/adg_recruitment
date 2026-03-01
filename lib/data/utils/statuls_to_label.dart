import '../models/applicationStatusModel.dart';
import '../models/job_application_model.dart';

String statusToLabel(ApplicationStatus s) {
  switch (s) {
    case ApplicationStatus.applied:
      return 'Resume received';
    case ApplicationStatus.under_review:
      return 'Under review';
    case ApplicationStatus.sent_to_company:
      return 'Sent to client';
    case ApplicationStatus.interview_invited:
      return 'Interview invited';
    case ApplicationStatus.interview_completed:
      return 'Interview completed';

  }
}

ApplicationStatus? labelToStatus(String label){
  switch (label) {
    case "applied":
      return ApplicationStatus.applied;
    case  'under_review' :
      return ApplicationStatus.under_review;
    case "sent_to_company":
      return ApplicationStatus.sent_to_company;
    case "interview_invited":
      return ApplicationStatus.interview_invited;
    case "interview_completed":
      return ApplicationStatus.interview_completed;

  }
  return null;
}