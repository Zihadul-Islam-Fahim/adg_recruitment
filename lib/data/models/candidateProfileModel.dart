class CandidateProfileModel {
  Data? data;

  CandidateProfileModel({this.data});

  CandidateProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? headline;
  String? recruiterId;
  String? expectedSalaryMin;
  String? expectedSalaryMax;
  String? preferredJobType;
  String? preferredLocation;
  String? totalExperienceYears;
  String? availability;
  String? availabilityWeeks;
  String? aboutMe;
  String? coverLetter;
  String? profilePhoto;
  String? cvFile;
  List<String>? skills;
  int? profileCompleteness;

  Data(
      {this.id,
        this.userId,
        this.headline,
        this.recruiterId,
        this.expectedSalaryMin,
        this.expectedSalaryMax,
        this.preferredJobType,
        this.preferredLocation,
        this.totalExperienceYears,
        this.availability,
        this.availabilityWeeks,
        this.aboutMe,
        this.coverLetter,
        this.profilePhoto,
        this.cvFile,
        this.skills,
        this.profileCompleteness});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    headline = json['headline'];
    recruiterId = json['recruiter_id'];
    expectedSalaryMin = json['expected_salary_min'];
    expectedSalaryMax = json['expected_salary_max'];
    preferredJobType = json['preferred_job_type'];
    preferredLocation = json['preferred_location'];
    totalExperienceYears = json['total_experience_years'];
    availability = json['availability'];
    availabilityWeeks = json['availability_weeks'];
    aboutMe = json['about_me'];
    coverLetter = json['cover_letter'];
    profilePhoto = json['profile_photo'];
    cvFile = json['cv_file'];
    skills = json['skills'].cast<String>();
    profileCompleteness = json['profile_completeness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['headline'] = this.headline;
    data['recruiter_id'] = this.recruiterId;
    data['expected_salary_min'] = this.expectedSalaryMin;
    data['expected_salary_max'] = this.expectedSalaryMax;
    data['preferred_job_type'] = this.preferredJobType;
    data['preferred_location'] = this.preferredLocation;
    data['total_experience_years'] = this.totalExperienceYears;
    data['availability'] = this.availability;
    data['availability_weeks'] = this.availabilityWeeks;
    data['about_me'] = this.aboutMe;
    data['cover_letter'] = this.coverLetter;
    data['profile_photo'] = this.profilePhoto;
    data['cv_file'] = this.cvFile;
    data['skills'] = this.skills;
    data['profile_completeness'] = this.profileCompleteness;
    return data;
  }
}
