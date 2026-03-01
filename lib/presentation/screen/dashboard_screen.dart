
import 'package:adg_recruitment/presentation/screen/candidate_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/models/applicationStatusModel.dart';
import '../../data/models/job_application_model.dart';
import '../controller/application_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/delete_account_controller.dart';
import '../widgets/application_card.dart';
import 'application_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    Get.find<JobApplicationController>().getJobs();
    super.initState();
  }


  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm logout'),
        content: const Text('Are you sure you want to log out? You will need to log in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // close dialog
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async { // show loading UI while logging out
              Get.back(); // close dialog first (optional)
              Get.find<AuthController>().clearAuthData();
              Get.offAllNamed('/login'); // or Get.offAll(() => LoginScreen());
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Logout'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Account",
            style: TextStyle(color: Colors.red)),
        content: Text(
            "This action is permanent and cannot be undone.\nDo you want to continue?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Delete"),
              onPressed: () async {
                bool res = await Get.find<DeleteAccountController>().deleteAccount();
                if(res){
                  Navigator.pop(context);
                  Get.find<AuthController>().clearAuthData();
                  Get.offAllNamed('/login');
                }else{
                  Navigator.pop(context);
                }

              }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to rebuild when controller.update() is called
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferred Jobs'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                showLogoutDialog();
              } else if (value == 'delete') {
                _showDeleteDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black54),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Delete Account',
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.indigo,
          child: Icon(CupertinoIcons.person_alt_circle,color: Colors.white,size: 40,),
          onPressed: (){
        Get.to(()=> CandidateProfileEditScreen());
      }),
      body: GetBuilder<JobApplicationController>(
        builder: (ctl) {
          final apps = ctl.jobApplicationModel?.jobApplicationList ?? [];
          return Visibility(
            visible: ctl.inProgress==false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: apps?.length ?? 0,
              itemBuilder: (ctx, i) {
                final a = apps![i];
                return ApplicationCard(application: a);
              },
            ),
          );
        },
      ),
    );
  }
}


// compact application card



  IconData _statusIcon(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.applied:
      case ApplicationStatus.under_review:
        return Icons.receipt_long;
      case ApplicationStatus.sent_to_company:
        return Icons.send;
      case ApplicationStatus.interview_invited:
      case ApplicationStatus.interview_completed:
        return Icons.event;

    }
  }

  Color _statusColor(ApplicationStatus s) {
    switch (s) {

      case ApplicationStatus.interview_invited:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String _statusShort(ApplicationStatus s) {
    switch (s) {
      case ApplicationStatus.applied:
        return 'Received';
      case ApplicationStatus.under_review:
        return 'Review';
      case ApplicationStatus.sent_to_company:
        return 'Sent';
      case ApplicationStatus.interview_invited:
        return 'Invite';
      case ApplicationStatus.interview_completed:
        return 'Done';

    }
  }

