import 'dart:developer';
import 'dart:io';
import 'package:adg_recruitment/data/models/candidateProfileModel.dart';
import 'package:adg_recruitment/data/models/network_response.dart';
import 'package:adg_recruitment/data/services/network_caller.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/urls.dart';

class CandidateProfileController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final headline = TextEditingController();
  final salaryMin = TextEditingController();
  final salaryMax = TextEditingController();
   String jobType =  'full-time';
  final location = TextEditingController();
  final experience = TextEditingController();
  final availability = TextEditingController();
  final coverLetter = TextEditingController();

  final List<String> commonJobTypes = [
    'full-time',
    'part-time',
    'contract',
    'remote',
  ];

  bool inProgress = false;
  bool hasFile = false;
  File? file;
  String fileName = "";
  CandidateProfileModel? candidateProfileModel;

  Future<void> pickFileDemo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      hasFile = true;
      update();
      file = File(result.files.single.path!);
      fileName = p.basename(file!.path);
      Get.snackbar('File', 'Attached', snackPosition: SnackPosition.BOTTOM);
    } else {
      hasFile = false;
      update();
    }
  }

  void loadData() async{
    inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller().getRequest(Urls.getProfile);

    if(response.isSuccess){
      candidateProfileModel = CandidateProfileModel.fromJson(response.responseData);

      final data = candidateProfileModel!.data;

      headline.text = data?.headline ?? '';
      salaryMin.text = data?.expectedSalaryMin ?? '';
      salaryMax.text = data?.expectedSalaryMax  ?? '';
      jobType = data?.preferredJobType ?? "";
      location.text = data?.preferredLocation ?? '';
      experience.text = data?.totalExperienceYears ?? '';
      availability.text = data?.availabilityWeeks ?? '';
      coverLetter.text = data?.coverLetter ?? '';
      fileName = data?.cvFile ?? "";

      inProgress= false;
      update();
    }




    //
    update();
  }

  void saveProfile() {
    if (!formKey.currentState!.validate()) return;

    final body = {
      "headline": headline.text,
      "expected_salary_min": salaryMin.text,
      "expected_salary_max": salaryMax.text,

      "preferred_location": location.text,
      "total_experience_years": experience.text,
      "availability_weeks": availability.text,
      "cover_letter": coverLetter.text,
    };

    print(body);

    Get.snackbar("Saved", "Profile updated successfully");
  }

  @override
  void onClose() {
    headline.dispose();
    salaryMin.dispose();
    salaryMax.dispose();

    location.dispose();
    experience.dispose();
    availability.dispose();
    coverLetter.dispose();
    super.onClose();
  }
}