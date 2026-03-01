import 'package:adg_recruitment/data/models/job_application_model.dart';
import 'package:adg_recruitment/data/models/network_response.dart';
import 'package:adg_recruitment/data/services/network_caller.dart';
import 'package:adg_recruitment/data/utils/urls.dart';
import 'package:get/get.dart';

import '../../data/models/applicationStatusModel.dart';


class JobApplicationController extends GetxController {

  bool inProgress = false;
  JobApplicationModel? jobApplicationModel;

  Future<void> getJobs()async{
    inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller().getRequest(Urls.getJobs);
    if(response.isSuccess){
      jobApplicationModel = JobApplicationModel.fromJson(response.responseData);

      inProgress = false;
      update();
    }
    inProgress = false;
    update();
  }





  JobApplication? findById(String id) => FirstWhereExt(jobApplicationModel!.jobApplicationList!).firstWhereOrNull((a) => a.id == id);

  // helper to simulate scheduling an interview
  void scheduleInterview(String id, DateTime dateTime) {
    final idx = jobApplicationModel!.jobApplicationList!.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      jobApplicationModel!.jobApplicationList![idx].applicationStatus = ApplicationStatus.interview_invited.toString();
      jobApplicationModel!.jobApplicationList![idx].interviewDate = dateTime.toString();
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
