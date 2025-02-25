// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_final_fields, use_build_context_synchronously, sort_child_properties_last, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//importing all required files
import 'screens/login/student.dart';
import 'screens/login/warden.dart';
import 'screens/login/ca.dart';
import 'screens/login/hod.dart';
import 'screens/login/vp.dart';
import 'screens/dashboard/warden.dart';
import 'screens/dashboard/ca.dart';
import 'screens/dashboard/hod.dart';
import 'screens/dashboard/vp.dart';
import 'screens/student-details/warden.dart';
import 'screens/student-details/ca.dart';
import 'screens/student-details/hod.dart';
import 'screens/student-details/vp.dart';
import 'screens/approved-pass/warden.dart';
import 'screens/approved-pass/ca.dart';
import 'screens/approved-pass/hod.dart';
import 'screens/approved-pass/vp.dart';
import 'screens/pending-pass/warden.dart';
import 'screens/pending-pass/ca.dart';
import 'screens/pending-pass/hod.dart';
import 'screens/pending-pass/vp.dart';
import 'screens/declined-pass/warden.dart';
import 'screens/declined-pass/ca.dart';
import 'screens/declined-pass/hod.dart';
import 'screens/declined-pass/vp.dart';
import 'screens/student/pass-apply.dart';
import 'screens/student/pass-history.dart';
import 'screens/warden/add-student.dart';
import 'screens/warden/add-pass.dart';
import 'screens/warden/add-department.dart';
import 'screens/warden/department.dart';
import 'screens/warden/pass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMS Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        //routings
        // dashboard 
        '/': (context) => DashboardScreen(),
        // login 
        '/student-login': (context) => StudentLoginPage(),
        '/warden-login': (context) => WardenLoginPage(),
        '/ca-login': (context) => CALoginPage(),
        '/hod-login': (context) => HODLoginPage(),
        '/vp-login': (context) => VPLoginPage(),
        // dashboard
        '/warden_dashboard': (context) => WardenDashboardScreen(),
        '/ca_dashboard': (context) => CADashboardScreen(),
        '/hod_dashboard': (context) => HODDashboardScreen(),
        '/vp_dashboard': (context) => VPDashboardScreen(),
        // student details
        '/student-details': (context) => StudentDetail(),
        '/ca-student-details': (context) => CAStudentDetail(),
        '/hod-student-details': (context) => HODStudentDetail(),
        '/vp-student-details': (context) => VPStudentDetail(),
        //pending pass
        '/pending-pass': (context) => PendingPass(),
        '/ca-pending-pass': (context) => CAPendingPassScreen(),
        '/hod-pending-pass': (context) => HODPendingPassScreen(),
        '/vp-pending-pass': (context) => VPPendingPass(),
        // approved pass
        '/approved-pass': (context) => ApprovedPass(),
        '/ca-approved-pass': (context) => CAApprovedPassScreen(),
        '/hod-approved-pass': (context) => HODApprovedPassScreen(),
        '/vp-approved-pass': (context) => VPApprovedPass(),
        // declined pass
        '/declined-pass': (context) => DeclinedPass(),
        '/ca-declined-pass': (context) => CADeclinedPassScreen(),
        '/hod-declined-pass': (context) => HODDeclinedPassScreen(),
        '/vp-declined-pass': (context) => VPDeclinedPass(),
        // pass
        '/pass': (context) => PassScreen(),
        '/pass-details': (context) => PassDetail(),
        // department
        '/dept-details': (context) => DepartmentDetail(),
      },
    );
  }
}
//default dashboard
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC),
      appBar: AppBar(
        title: Text('Welcome to HOMS', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Select Your Role!',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  RoleCard(title: 'Student', icon: Icons.school, route: '/student-login'),
                  RoleCard(title: 'Warden', icon: Icons.security, route: '/warden-login'),
                  RoleCard(title: 'Class Advisor', icon: Icons.supervisor_account, route: '/ca-login'),
                  RoleCard(title: 'HoD', icon: Icons.business, route: '/hod-login'),
                  RoleCard(title: 'Principal/Vice Principal', icon: Icons.account_balance, route: '/vp-login'),
                  // RoleCard(title: 'Pass', icon: Icons.assignment, route: '/pass'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Rolecard Antha Box Mari Role Select Pana
class RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  RoleCard({required this.title, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        color: Colors.white,
        shadowColor: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.blueAccent),
            SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


