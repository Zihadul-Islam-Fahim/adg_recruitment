import 'package:adg_recruitment/controller_binder.dart';
import 'package:adg_recruitment/presentation/controller/application_controller.dart';
import 'package:adg_recruitment/presentation/screen/application_details_screen.dart';
import 'package:adg_recruitment/presentation/screen/dashboard_screen.dart';
import 'package:adg_recruitment/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


import 'data/models/job_application_model.dart';

void main() {

  Get.put(AppController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recruiting Candidate App (GetX)',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarThemeData(backgroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo)),
        inputDecorationTheme: InputDecorationTheme(

          // ---------- TEXT STYLE ----------

          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),

          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF94A3B8),
          ),

          floatingLabelStyle: const TextStyle(
            color: Color(0xFF2563EB),
            fontWeight: FontWeight.w600,
          ),

          // ---------- FIELD PADDING ----------
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),

          // ---------- DEFAULT BORDER ----------
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),

          // ---------- ENABLED ----------
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),

          // ---------- FOCUSED ----------
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF233662),
              width: 1.8,
            ),
          ),

          // ---------- ERROR ----------
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFEF4444),
              width: 1.5,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDC2626),
              width: 1.8,
            ),
          ),

          // ---------- FILL ----------
          filled: true,
          fillColor: const Color(0xFFF8FAFC),


          // ---------- ICONS ----------
          prefixIconColor: Color(0xFF64748B),
          suffixIconColor: Color(0xFF64748B),

          // ---------- ERROR STYLE ----------
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/detail/:id', page: () => ApplicationDetailScreen()),
      ],
      debugShowCheckedModeBanner: false,

    );
  }
}



