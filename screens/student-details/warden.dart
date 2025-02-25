// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../warden/add-student.dart';
class StudentDetail extends StatefulWidget {
  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  List<Map<String, String>> studentList = [];

  Future<List<Map<String, String>>> fetchStudentData() async {
    final response = await http.get(Uri.parse('https://reshist.me/homspwa/api/warden-student.php'));

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
      }
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    fetchStudentData();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentPage()),
          );
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}