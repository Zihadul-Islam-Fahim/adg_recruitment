class JobApplicationModel {
  List<JobApplication>? jobApplicationList;

  JobApplicationModel({this.jobApplicationList});

  JobApplicationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      jobApplicationList = <JobApplication>[];
      json['data'].forEach((v) {
        jobApplicationList!.add(new JobApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobApplicationList != null) {
      data['data'] = this.jobApplicationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobApplication {
  int? id;
  String? jobId;
  String? candidateId;
  String? applicationStatus;
  String? interviewDate;
  String? interviewNote;
  String? meetingUrl;
  String? finalStatus;
  Job? job;
  String? createdAt;

  JobApplication(
      {this.id,
        this.jobId,
        this.candidateId,
        this.applicationStatus,
        this.interviewDate,
        this.interviewNote,
        this.meetingUrl,
        this.finalStatus,
        this.job,
        this.createdAt});

  JobApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    applicationStatus = json['application_status'];
    interviewDate = json['interview_date'];
    interviewNote = json['interview_note'];
    meetingUrl = json['meeting_url'];
    finalStatus = json['final_status'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['application_status'] = this.applicationStatus;
    data['interview_date'] = this.interviewDate;
    data['interview_note'] = this.interviewNote;
    data['meeting_url'] = this.meetingUrl;
    data['final_status'] = this.finalStatus;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Job {
  int? id;
  String? companyId;
  String? jobTitle;
  String? jobCategory;
  String? jobType;
  String? vacancyCount;
  String? salaryMin;
  String? salaryMax;
  String? salaryType;
  String? experienceMinYear;
  String? experienceMaxYear;
  String? educationRequirement;
  String? jobLocation;
  String? applicationDeadline;
  String? description;
  String? benefits;
  String? urgency;
  String? status;
  String? attachments;
  String? createdAt;

  Job(
      {this.id,
        this.companyId,
        this.jobTitle,
        this.jobCategory,
        this.jobType,
        this.vacancyCount,
        this.salaryMin,
        this.salaryMax,
        this.salaryType,
        this.experienceMinYear,
        this.experienceMaxYear,
        this.educationRequirement,
        this.jobLocation,
        this.applicationDeadline,
        this.description,
        this.benefits,
        this.urgency,
        this.status,
        this.attachments,
        this.createdAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    jobTitle = json['job_title'];
    jobCategory = json['job_category'];
    jobType = json['job_type'];
    vacancyCount = json['vacancy_count'];
    salaryMin = json['salary_min'];
    salaryMax = json['salary_max'];
    salaryType = json['salary_type'];
    experienceMinYear = json['experience_min_year'];
    experienceMaxYear = json['experience_max_year'];
    educationRequirement = json['education_requirement'];
    jobLocation = json['job_location'];
    applicationDeadline = json['application_deadline'];
    description = json['description'];
    benefits = json['benefits'];
    urgency = json['urgency'];
    status = json['status'];
    attachments = json['attachments'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['job_title'] = this.jobTitle;
    data['job_category'] = this.jobCategory;
    data['job_type'] = this.jobType;
    data['vacancy_count'] = this.vacancyCount;
    data['salary_min'] = this.salaryMin;
    data['salary_max'] = this.salaryMax;
    data['salary_type'] = this.salaryType;
    data['experience_min_year'] = this.experienceMinYear;
    data['experience_max_year'] = this.experienceMaxYear;
    data['education_requirement'] = this.educationRequirement;
    data['job_location'] = this.jobLocation;
    data['application_deadline'] = this.applicationDeadline;
    data['description'] = this.description;
    data['benefits'] = this.benefits;
    data['urgency'] = this.urgency;
    data['status'] = this.status;
    data['attachments'] = this.attachments;
    data['created_at'] = this.createdAt;
    return data;
  }
}
