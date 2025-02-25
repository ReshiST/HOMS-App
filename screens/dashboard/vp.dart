// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
class VPDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC),
      appBar: AppBar(
        title: Text('Principla/ VP', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
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
              'Dashboard',
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
                  RoleCard(title: 'Registered Student', icon: Icons.supervisor_account, route: '/vp-student-details'),
                  RoleCard(title: 'Pending Application', icon: Icons.rotate_90_degrees_cw, route: '/vp-pending-pass'),
                  RoleCard(title: 'Declined Application', icon: Icons.do_disturb, route: '/vp-declined-pass'),
                  RoleCard(title: 'Approved Application', icon: Icons.done_all_outlined, route: '/vp-approved-pass'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}