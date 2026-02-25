import '../models/job_application_model.dart';

String statusToLabel(ApplicationStatus s) {
  switch (s) {
    case ApplicationStatus.resumeReceived:
      return 'Resume received';
    case ApplicationStatus.underReview:
      return 'Under review';
    case ApplicationStatus.sentToClient:
      return 'Sent to client';
    case ApplicationStatus.interviewInvited:
      return 'Interview invited';
    case ApplicationStatus.interviewDone:
      return 'Interview completed';
    case ApplicationStatus.offer:
      return 'Offer';
    case ApplicationStatus.rejection:
      return 'Rejection';
  }
}