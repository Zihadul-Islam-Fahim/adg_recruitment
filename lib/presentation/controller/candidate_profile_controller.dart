import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adg_recruitment/data/models/candidateProfileModel.dart';
import 'package:adg_recruitment/data/models/network_response.dart';
import 'package:adg_recruitment/data/services/network_caller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/urls.dart';
import 'auth_controller.dart';

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
  bool buttonInProgress = false;
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

    inProgress= false;
    update();
  }




  Future<bool> saveProfile()async{

    try{
      buttonInProgress = true;
      update();

      var uri = Uri.parse(Urls.postProfile);
      log(Urls.postProfile);
      var request = http.MultipartRequest('POST', uri);

      final token = AuthController.token;
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Attach fields
      request.fields['headline'] = headline.text;
      request.fields['expected_salary_min'] = salaryMin.text;
      request.fields['expected_salary_max'] = salaryMax.text;
      request.fields['preferred_job_type'] = jobType;
      request.fields['preferred_location'] = location.text;
      request.fields['total_experience_years'] = experience.text;
      request.fields['availability_weeks'] = availability.text;
      request.fields['skills[]'] = "null";



      if(hasFile){
        final cvFile = await File(file!.path).readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'cv_file',
          cvFile,
          filename: p.basename(file!.path),
        ));
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        buttonInProgress = false;
        update();

        log(response.statusCode.toString());
        log(response.body);
        Get.snackbar('Success', "Profile Update Successful !!",
            backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        log(response.statusCode.toString());
        log(response.body);

        var p = jsonDecode(response.body);


        Get.snackbar('Something went wrong!', 'Try again',
            backgroundColor: Colors.red, colorText: Colors.white);
        buttonInProgress = false;
        update();

        return false;
      }
    } catch (e) {
      log(e.toString());
      buttonInProgress = false;
      update();
      return false;
    }
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