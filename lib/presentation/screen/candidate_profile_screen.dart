import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/candidate_profile_controller.dart';


class CandidateProfileEditScreen extends StatefulWidget {
  const CandidateProfileEditScreen({super.key});


  @override
  State<CandidateProfileEditScreen> createState() => _CandidateProfileEditScreenState();
}

class _CandidateProfileEditScreenState extends State<CandidateProfileEditScreen> {

  @override
  void initState() {
   Get.find<CandidateProfileController>().loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<CandidateProfileController>(

      builder: (c) {

        return Scaffold(
          appBar: AppBar(title: const Text("Edit Profile")),
          body: Visibility(
            visible: c.inProgress==false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: Form(
              key: c.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    _sectionTitle("Professional Headline"),
                    _field("Professional Headline", c.headline),

                    _sectionTitle("Preferred Location"),
                    _field("Preferred Location", c.location),

                    _sectionTitle("Experience (Years)"),
                    _field("Experience (Years)", c.experience, number: true),

                    _sectionTitle("Availability (Weeks)"),
                    _field("Availability (Weeks)", c.availability, number: true),


                    _sectionTitle("Min & Max Salary Expectation"),

                    Row(children: [
                      Expanded(child: _field("Min Salary", c.salaryMin, number: true)),
                      const SizedBox(width: 12),
                      Expanded(child: _field("Max Salary", c.salaryMax, number: true)),
                    ]),

                    _sectionTitle("Preferred Job Type"),
                    DropdownButtonFormField<String>(
                      value: c.jobType,
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: Colors.white,
                      items: [null, ...c.commonJobTypes].map((p) {
                        if (p == null) return const DropdownMenuItem<String>(value: null, child: Text('Select job type'),);
                        return DropdownMenuItem<String>(value: p, child: Text(p),);
                      }).toList(),
                      onChanged: (v) => setState(() => c.jobType = v!),
                      decoration: const InputDecoration(),
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("Cover Letter"),

                    _field("Cover Letter", c.coverLetter, maxLines: 5),

                    const SizedBox(height: 12),
                    ElevatedButton.icon(onPressed: c.pickFileDemo, icon: const Icon(Icons.attach_file,color: Colors.white,), label: const Text('Attach CV file (PDF)',style: TextStyle(color: Colors.white),)),
                    const SizedBox(height: 12),
                    Row(children: [

                      const SizedBox(width: 9),
                      if (c.hasFile) SizedBox(
                          width: Get.width * 0.9,
                          child: Text(c.fileName,overflow: TextOverflow.fade, style: const TextStyle(color: Colors.grey))),
                    ]),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: c.buttonInProgress==false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: (){
                            if(c.formKey.currentState!.validate()){
                              c.saveProfile();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Update Profile", style: TextStyle(fontSize: 16,color: Colors.white)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Text(text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller,
      {bool number = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          // labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}