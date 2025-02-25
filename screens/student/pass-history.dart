// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
class PassHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> passHistory = [
    {
      'fromDate': '2024-01-10',
      'toDate': '2024-01-12',
      'status': 'Approved',
      'leaveType': 'Out Pass',
      'description': 'Family function',
    },
    {
      'fromDate': '2024-02-01',
      'toDate': '2024-02-05',
      'status': 'Pending',
      'leaveType': 'Home Pass',
      'description': 'Visit to hometown',
    },
    {
      'fromDate': '2024-02-21',
      'toDate': '2024-03-02',
      'status': 'Pending',
      'leaveType': 'Home Pass',
      'description': 'Placement Drive',
    },
    {
      'fromDate': '2024-03-24',
      'toDate': '2024-03-30',
      'status': 'Pending',
      'leaveType': 'Out Pass',
      'description': 'Hospital',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pass History', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: passHistory.length,
          itemBuilder: (context, index) {
            final pass = passHistory[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text('${pass['leaveType']} (${pass['status']})', style: GoogleFonts.poppins(fontSize: 18)),
                subtitle: Text(
                  'From: ${pass['fromDate']} To: ${pass['toDate']}\nDescription: ${pass['description']}',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}