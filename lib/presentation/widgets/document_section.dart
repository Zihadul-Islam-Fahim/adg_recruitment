import 'package:flutter/material.dart';

class DocumentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Row(children: [
        _docTile('CV.pdf'),
        SizedBox(width: 8),
        _docTile('Passport.jpg'),
        SizedBox(width: 8),
        ElevatedButton.icon(onPressed: () {}, icon: Icon(Icons.upload_file), label: Text('Upload')),
      ]),
    ]);
  }

  Widget _docTile(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(Icons.insert_drive_file, size: 20),
        SizedBox(width: 8),
        Text(name),
      ]),
    );
  }
}