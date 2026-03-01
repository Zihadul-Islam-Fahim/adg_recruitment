import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/models/applicationStatusModel.dart';
import '../../data/models/job_application_model.dart';
import '../../data/utils/job_info_tile.dart';
import '../controller/application_controller.dart';
import '../widgets/document_section.dart';
import '../widgets/interview_card.dart';
import '../widgets/timeline_stepper.dart';

class ApplicationDetailScreen extends StatefulWidget {
  JobApplication jobApplication;
   ApplicationDetailScreen({super.key,required this.jobApplication});

  @override
  State<ApplicationDetailScreen> createState() => _ApplicationDetailScreenState();
}

class _ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
  @override
  Widget build(BuildContext context) {

    // Use GetBuilder to rebuild when controller updates
    return GetBuilder<JobApplicationController>(
      builder: (ctl) {
        final app = widget.jobApplication;

        return Scaffold(
          appBar: AppBar(title: Text("Details")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(app.job?.jobTitle ?? "", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Text(app.job!.companyId!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Text('Applied on ${DateFormat.yMMMd().format(DateTime.parse(app.createdAt!))}', style: TextStyle(color: Colors.grey[700])),

              SizedBox(height: 18),

              Text('Application Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              TimelineStepper(application: app),

              SizedBox(height: 20),
              if (app.applicationStatus == 'interview_invited')
                InterviewCard(interviewAt: DateTime.parse(app.interviewDate!),url: app.meetingUrl ?? "",interviewNote: app.interviewNote,),

              SizedBox(height: 10),
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [

                      JobInfoTile(
                        icon: Icons.email_outlined,
                        label: "Company Email",
                        value: app.job?.jobCategory ?? "",
                      ),

                      const SizedBox(height: 16),

                      JobInfoTile(
                        icon: Icons.work_outline_rounded,
                        label: "Job Type",
                        value: app.job?.jobType ?? "",
                      ),

                      const SizedBox(height: 16),

                      JobInfoTile(
                        icon: Icons.location_on_outlined,
                        label: "Job Location",
                        value: app.job?.jobLocation ?? "",
                      ),

                      const SizedBox(height: 16),

                      JobInfoTile(
                        icon: Icons.phone_outlined,
                        label: "Phone Number",
                        value: app.job?.benefits ?? "",
                      ),

                      const SizedBox(height: 16),

                      JobInfoTile(
                        icon: Icons.priority_high_rounded,
                        label: "Urgency",
                        value: app.job?.urgency ?? "",
                        valueColor: urgencyColor(app.job?.urgency),
                      ),
                    ],
                  ),
                ),
              ),
              // DocumentsSection(),

              SizedBox(height: 20),




            ]),
          ),
        );
      },
    );
  }
}