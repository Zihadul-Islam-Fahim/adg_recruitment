import 'package:adg_recruitment/presentation/screen/apply_screen.dart';
import 'package:adg_recruitment/presentation/screen/candidate_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/models/job_application_model.dart';
import '../controller/application_controller.dart';
import '../widgets/application_card.dart';
import 'application_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to rebuild when controller.update() is called
    return Scaffold(
      appBar: AppBar(
        title: Text('My Applications'),
        actions: [
          IconButton(icon: Icon(Icons.person), onPressed: () {Get.to(()=> CandidateProfileEditScreen());}),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: (){
        Get.to(()=> CandidateApplyScreen());
      }),
      body: GetBuilder<AppController>(
        builder: (ctl) {
          final apps = ctl.apps;
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: apps.length,
            itemBuilder: (ctx, i) {
              final a = apps[i];
              return ApplicationCard(application: a);
            },
          );
        },
      ),
    );
  }
}


// compact application card



  IconData _statusIcon(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.resumeReceived:
      case ApplicationStatus.underReview:
        return Icons.receipt_long;
      case ApplicationStatus.sentToClient:
        return Icons.send;
      case ApplicationStatus.interviewInvited:
      case ApplicationStatus.interviewDone:
        return Icons.event;
      case ApplicationStatus.offer:
        return Icons.thumb_up;
      case ApplicationStatus.rejection:
        return Icons.close;
    }
  }

  Color _statusColor(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.offer:
        return Colors.green;
      case ApplicationStatus.rejection:
        return Colors.red;
      case ApplicationStatus.interviewInvited:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String _statusShort(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.resumeReceived:
        return 'Received';
      case ApplicationStatus.underReview:
        return 'Review';
      case ApplicationStatus.sentToClient:
        return 'Sent';
      case ApplicationStatus.interviewInvited:
        return 'Invite';
      case ApplicationStatus.interviewDone:
        return 'Done';
      case ApplicationStatus.offer:
        return 'Offer';
      case ApplicationStatus.rejection:
        return 'Rejected';
    }
  }

