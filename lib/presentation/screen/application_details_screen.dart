import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/models/job_application_model.dart';
import '../controller/application_controller.dart';
import '../widgets/document_section.dart';
import '../widgets/interview_card.dart';
import '../widgets/timeline_stepper.dart';

class ApplicationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'] ?? '';
    // Use GetBuilder to rebuild when controller updates
    return GetBuilder<AppController>(
      builder: (ctl) {
        final app = ctl.findById(id);
        if (app == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Not found')),
            body: Center(child: Text('Application not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(app.title)),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(app.company, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Text('Applied on ${DateFormat.yMMMd().format(app.appliedAt)}', style: TextStyle(color: Colors.grey[700])),
              SizedBox(height: 18),

              Text('Application Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              TimelineStepper(application: app),

              SizedBox(height: 20),
              if (app.status == ApplicationStatus.interviewInvited && app.interviewAt != null)
                InterviewCard(interviewAt: app.interviewAt!),

              SizedBox(height: 20),
              DocumentsSection(),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // open chat (not implemented)
                  Get.snackbar('Chat', 'Open chat with recruiter (not implemented)');
                },
                icon: Icon(Icons.chat_bubble_outline),
                label: Text('Message recruiter'),
              ),
              SizedBox(height: 10),
              // demo controls to mutate state (useful while testing)
              Wrap(spacing: 8, children: [
                OutlinedButton(
                  onPressed: () => ctl.updateStatus(app.id, ApplicationStatus.sentToClient),
                  child: Text('Mark Sent'),
                ),
                OutlinedButton(
                  onPressed: () => ctl.scheduleInterview(app.id, DateTime.now().add(Duration(days: 3, hours: 10))),
                  child: Text('Schedule Interview'),
                ),
                OutlinedButton(
                  onPressed: () => ctl.updateStatus(app.id, ApplicationStatus.offer),
                  child: Text('Mark Offer'),
                ),
              ]),
            ]),
          ),
        );
      },
    );
  }
}