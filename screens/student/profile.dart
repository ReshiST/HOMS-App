// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
class MyProfile extends StatelessWidget {
  final List<Map<String, String>> passHistory = [
    {
      'fname': 'Reshi',
      'lname': 'S T',
      'dept': 'Information technology',
      'mail': '2k21it44@kiot.ac.in',
      'number': '+91 9842778900',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
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
                title: Text('Name: ${pass['fname']} ${pass['lname']}', style: GoogleFonts.poppins(fontSize: 18)),
                subtitle: Text('Dept: ${pass['dept']}\nMail: ${pass['mail']}\nNumber: ${pass['number']}', style: GoogleFonts.poppins(fontSize: 18)),
                // title: Text('Mail: ${pass['mail']}', style: GoogleFonts.poppins(fontSize: 18)),
                // title: Text('Number: ${pass['number']}', style: GoogleFonts.poppins(fontSize: 18)),
                // subtitle: Text(
                //   'Dept: ${pass['dept']} \nMail: ${pass['mail']}\nNumber: ${pass['number']}',
                //   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                // ),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddStudentPage()),
      //     );
      //   },
      //   child: Icon(Icons.add, size: 30),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }
}