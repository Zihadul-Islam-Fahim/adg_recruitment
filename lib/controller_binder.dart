import 'package:adg_recruitment/presentation/controller/application_controller.dart';
import 'package:adg_recruitment/presentation/controller/auth_controller.dart';
import 'package:adg_recruitment/presentation/controller/candidate_profile_controller.dart';
import 'package:adg_recruitment/presentation/controller/delete_account_controller.dart';
import 'package:adg_recruitment/presentation/controller/login_controller.dart';
import 'package:get/get.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {

    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(CandidateProfileController());
    Get.put(JobApplicationController());
    Get.put(DeleteAccountController());


  }
}