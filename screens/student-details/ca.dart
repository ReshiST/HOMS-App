// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
class CAStudentDetail extends StatefulWidget {
  @override
  _CAStudentDetailState createState() => _CAStudentDetailState();
}

class _CAStudentDetailState extends State<CAStudentDetail> {
  List<Map<String, String>> studentList = [];

  // Fetch student data from API using CA name from SharedPreferences
  Future<List<Map<String, String>>> fetchStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? caName = prefs.getString("ca"); // Retrieve CA name from session
    
    if (caName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: CA Name not found in session')),
      );
      return [];
    }

    final response = await http.post(
      Uri.parse('https://reshist.me/homspwa/api/ca-students.php'),
      body: {
        "ca": caName, // Send CA name to the API
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        setState(() {
          studentList = List<Map<String, String>>.from(data['data'].map((item) => {
            'fname': item['FirstName'].toString(),
            'lname': item['LastName'].toString(),
            'dept': item['Department'].toString(),
            'stid': item['EmpId'].toString(),
            // 'number': item['PhoneNumber'].toString(),
          }));
        });
        return studentList;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No students found for the given CA.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load student data.')),
      );
    }
    return []; // Return an empty list if API fails
  }

  @override
  void initState() {
    super.initState();
    fetchStudentData(); // Call function to fetch data when the screen is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            final student = studentList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text('${student['fname']} ${student['lname']}', style: GoogleFonts.poppins(fontSize: 18)),
                subtitle: Text(
                  'Dept: ${student['dept']} \nStudent ID: ${student['stid']}',
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
