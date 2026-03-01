import 'package:adg_recruitment/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool useId = false;
  final _emailCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Candidate Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<LoginController>(
          builder: (loginController) {
            return Column(
              children: [
                ToggleButtons(
                  isSelected: [!useId, useId],

                  onPressed: (i) => setState(() => useId = i == 1),
                  children: [Padding(padding: EdgeInsets.all(8), child: Text('Recruiter ID')), Padding(padding: EdgeInsets.all(8), child: Text('Email & Password'))],
                ),
                SizedBox(height: 20),
                if (!useId) ...[
                  TextField(
                    controller: _idCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Recruiter ID',),
                  ),
                  SizedBox(height: 12),
                  MaterialButton(
                      height: 50,
                      minWidth: Get.width*0.9,
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
                      onPressed: () async {
                        if(_idCtrl.text.isEmpty){
                          Get.snackbar("Failed", "Enter Id",colorText: Colors.white,backgroundColor: Colors.red);
                        }else{
                          bool res = await loginController.idLogin(_idCtrl.text);
                          if(res){
                            Get.offAllNamed('/dashboard');
                          }
                        }

                      }, child: loginController.inProgress ? CircularProgressIndicator(color: Colors.white,) : Text('Login',style: TextStyle(color: Colors.white),)),
                ] else ...[
                  TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
                  SizedBox(height: 12),
                  TextField(controller: _pinCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
                  SizedBox(height: 12),
                  MaterialButton(
                      height: 50,
                      minWidth: Get.width*0.9,
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
                      onPressed: () async {
                        if (_emailCtrl.text.isEmpty || _pinCtrl.text.isEmpty) {
                          Get.snackbar("Failed", "Enter email & password", colorText: Colors
                              .white, backgroundColor: Colors.red);
                        } else {
                          bool res = await loginController.emailLogin(
                              _emailCtrl.text, _pinCtrl.text);
                          if (res) {
                            Get.offAllNamed('/dashboard');
                          }
                        }
                  }, child: loginController.inProgress ? CircularProgressIndicator(color: Colors.white,) : Text('Login',style: TextStyle(color: Colors.white),)),
                ],

              ],
            );
          }
        ),
      ),
    );
  }
}