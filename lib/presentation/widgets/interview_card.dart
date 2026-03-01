import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class InterviewCard extends StatelessWidget {
  final DateTime interviewAt;
  String? url;
  String? interviewNote;

   InterviewCard({required this.interviewAt, this.url,this.interviewNote});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat.yMMMMd().add_jm();
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.event),
            SizedBox(width: 8),
            Text('Interview scheduled',
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          SizedBox(height: 8),
          Text(f.format(interviewAt)),
          Text(interviewNote ?? ""),
          SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            ElevatedButton.icon(onPressed: () {
              openDeviceCalendar();
            },
                icon: Icon(Icons.calendar_today,color: Colors.white,),
                label: Text('Add to calendar',style: TextStyle(color: Colors.white),)),
            OutlinedButton.icon(onPressed: () {
              _launchUrl(url ?? "");
            }, icon: Icon(Icons.videocam), label: Text('Join meeting')),
          ]),
        ]),
      ),
    );
  }



  void openDeviceCalendar() async {
    Uri url;

    if (Platform.isAndroid) {
      // You can use 'content://com.android.calendar/time/' to open to a specific time/event
      url = Uri.parse('content://com.android.calendar/time/');
    } else if (Platform.isIOS) {
      // 'calshow://' opens the app to the current date
      url = Uri.parse('calshow://');
    } else {
      // Fallback or show a dialog for unsupported platforms
      print('Unsupported platform');
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }

  Future<void> _launchUrl(String mainUrl) async {
    final Uri url = Uri.parse(mainUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}