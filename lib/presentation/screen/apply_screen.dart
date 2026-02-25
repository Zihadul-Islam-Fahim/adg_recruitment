// lib/screens/candidate_apply_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart'; // uncomment if you install file_picker

/// --- MODEL ---
class CandidateApplication {
  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String? recruiterId;
  final String position;
  final String coverLetter;
  final int availabilityWeeks;
  final String location;
  final String? resumeFileName;
  final DateTime createdAt;

  CandidateApplication({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.recruiterId,
    required this.position,
    required this.coverLetter,
    required this.availabilityWeeks,
    required this.location,
    this.resumeFileName,
    required this.createdAt,
  });
}

/// --- CONTROLLER (GetX, non-Rx, uses update()) ---
class CandidateController extends GetxController {
  // In-memory store (demo). Replace with API integration.
  final List<CandidateApplication> applications = [];

  // Form controllers (managed by controller)
  late final TextEditingController nameCtrl;
  late final TextEditingController phoneCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController recruiterIdCtrl;
  late final TextEditingController positionCtrl;
  late final TextEditingController coverCtrl;
  late final TextEditingController availabilityCtrl;
  late final TextEditingController locationCtrl;

  // UI state
  String? selectedPosition;
  String? resumeFileName;
  bool consent = false;
  bool submitting = false;

  // sample positions
  final List<String> commonPositions = [
    'Software Engineer',
    'Customer Support',
    'Driver',
    'Cleaner',
    'Nurse',
    'Accountant',
  ];

  @override
  void onInit() {
    super.onInit();
    nameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    recruiterIdCtrl = TextEditingController();
    positionCtrl = TextEditingController();
    coverCtrl = TextEditingController();
    availabilityCtrl = TextEditingController(text: '0');
    locationCtrl = TextEditingController();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    recruiterIdCtrl.dispose();
    positionCtrl.dispose();
    coverCtrl.dispose();
    availabilityCtrl.dispose();
    locationCtrl.dispose();
    super.onClose();
  }

  // Add a new application (in-memory, replace with API call)
  void createApplication(CandidateApplication a) {
    applications.insert(0, a);
    update(); // update UI lists
    // TODO: call backend and notify user on success/failure
    Get.snackbar('Application submitted', 'Thank you, ${a.fullName}', snackPosition: SnackPosition.BOTTOM);
  }

  CandidateApplication? findById(String id) => FirstWhereExt(applications).firstWhereOrNull((e) => e.id == id);

  // UI helpers (update state + notify)
  void setSelectedPosition(String? pos) {
    selectedPosition = pos;
    update();
  }

  Future<void> pickResumeDemo() async {
    // Demo: set fake file name. Replace with file_picker logic when ready.
    // FilePickerResult? res = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','doc','docx']);
    // if (res != null) { resumeFileName = res.files.single.name; update(); }
    resumeFileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
    update();
    Get.snackbar('File attached', resumeFileName!, snackPosition: SnackPosition.BOTTOM);
  }

  void clearResume() {
    resumeFileName = null;
    update();
  }

  void toggleConsent(bool? v) {
    consent = v ?? false;
    update();
  }

  Future<void> submitApplication(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;
    if (!consent) {
      Get.snackbar('Consent', 'Please accept the privacy & terms to continue', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    submitting = true;
    update();

    final position = (selectedPosition != null && selectedPosition!.isNotEmpty)
        ? selectedPosition!
        : positionCtrl.text.trim();

    final app = CandidateApplication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: nameCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      email: emailCtrl.text.trim().isEmpty ? null : emailCtrl.text.trim(),
      recruiterId: recruiterIdCtrl.text.trim().isEmpty ? null : recruiterIdCtrl.text.trim(),
      position: position,
      coverLetter: coverCtrl.text.trim(),
      availabilityWeeks: int.tryParse(availabilityCtrl.text.trim()) ?? 0,
      location: locationCtrl.text.trim(),
      resumeFileName: resumeFileName,
      createdAt: DateTime.now(),
    );

    // Simulate network latency - replace with actual API call
    await Future.delayed(const Duration(milliseconds: 600));
    createApplication(app);

    submitting = false;
    // reset form fields
    nameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    recruiterIdCtrl.clear();
    positionCtrl.clear();
    coverCtrl.clear();
    availabilityCtrl.text = '0';
    locationCtrl.clear();
    selectedPosition = null;
    resumeFileName = null;
    consent = false;
    update();

    // show dialog
    Get.dialog(AlertDialog(
      title: const Text('Application submitted'),
      content: const Text('Your application was submitted successfully. The recruiter will contact you.'),
      actions: [TextButton(onPressed: () => Get.back(), child: const Text('OK'))],
    ));
  }
}

/// Small helper extension
extension FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) if (test(e)) return e;
    return null;
  }
}

/// --- SCREEN (uses GetBuilder only; no setState) ---
class CandidateApplyScreen extends StatelessWidget {
  CandidateApplyScreen({super.key});

  // ensure the controller is registered
  final CandidateController ctl = Get.put(CandidateController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply as Candidate')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: GetBuilder<CandidateController>(
          builder: (c) {
            return Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Candidate application', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text('Fill the form below to apply. Recruiter will review and update status.'),
                const SizedBox(height: 16),

                // NAME & PHONE (required)
                TextFormField(
                  controller: c.nameCtrl,
                  decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person)),
                  validator: (v) => (v == null || v.trim().length < 2) ? 'Enter full name' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: c.phoneCtrl,
                  decoration: const InputDecoration(labelText: 'Phone number', prefixIcon: Icon(Icons.phone)),
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Phone is required' : null,
                ),
                const SizedBox(height: 8),

                // Email & Recruiter ID (optional)
                TextFormField(controller: c.emailCtrl, decoration: const InputDecoration(labelText: 'Email (optional)', prefixIcon: Icon(Icons.email)), keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 8),
                TextFormField(controller: c.recruiterIdCtrl, decoration: const InputDecoration(labelText: 'Recruiter ID (if provided)', prefixIcon: Icon(Icons.badge_outlined))),
                const SizedBox(height: 12),

                // Position: select or type
                const Text('Position', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: c.selectedPosition,
                      hint: const Text('Choose common position'),
                      items: [null, ...c.commonPositions].map((p) {
                        if (p == null) return const DropdownMenuItem<String>(value: null, child: Text('Select or type below'));
                        return DropdownMenuItem<String>(value: p, child: Text(p));
                      }).toList(),
                      onChanged: (v) => c.setSelectedPosition(v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(controller: c.positionCtrl, decoration: const InputDecoration(labelText: 'Or type position (overrides)')),
                  ),
                ]),
                const SizedBox(height: 12),

                // Location & Availability
                Row(children: [
                  Expanded(child: TextFormField(controller: c.locationCtrl, decoration: const InputDecoration(labelText: 'Preferred location'))),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      controller: c.availabilityCtrl,
                      decoration: const InputDecoration(labelText: 'Avail (wks)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ]),
                const SizedBox(height: 12),

                // Cover letter / job notes
                const Text('Cover letter / notes', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                TextFormField(controller: c.coverCtrl, maxLines: 5, decoration: const InputDecoration(hintText: 'Skills, experience, short intro...')),
                const SizedBox(height: 12),

                // Resume upload
                Row(children: [
                  ElevatedButton.icon(onPressed: () => c.pickResumeDemo(), icon: const Icon(Icons.attach_file), label: const Text('Attach resume')),
                  const SizedBox(width: 12),
                  Expanded(child: Text(c.resumeFileName ?? 'No file attached', overflow: TextOverflow.ellipsis)),
                  if (c.resumeFileName != null) IconButton(onPressed: () => c.clearResume(), icon: const Icon(Icons.close))
                ]),
                const SizedBox(height: 12),

                // Consent
                Row(children: [
                  Checkbox(value: c.consent, onChanged: (v) => c.toggleConsent(v)),
                  const Expanded(child: Text('I consent to the processing of my application and personal data.')),
                ]),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: c.submitting ? null : () => c.submitApplication(_formKey),
                    child: c.submitting
                        ? const Padding(padding: EdgeInsets.all(12), child: SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
                        : const Padding(padding: EdgeInsets.all(12), child: Text('Submit application')),
                  ),
                ),

                const SizedBox(height: 20),

                // Optional: show small list of previous apps for the candidate (reads from controller)
                if (c.applications.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text('Your recent applications', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ...c.applications.map((a) => ListTile(
                    title: Text(a.position),
                    subtitle: Text('${a.fullName} — submitted ${a.createdAt}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // open detail if you have such screen
                    },
                  )),
                ],

                const SizedBox(height: 40),
              ]),
            );
          },
        ),
      ),
    );
  }
}