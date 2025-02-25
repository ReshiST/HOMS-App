// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import 'add-pass.dart';
import 'add-department.dart';
class DepartmentDetail extends StatefulWidget {
  @override
  _DepartmentDetailState createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> {
  List<Map<String, String>> studentList = [];

  Future<void> fetchStudentData() async {
    final response = await http.get(Uri.parse('https://reshist.me/homspwa/api/warden-department.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] && data['data'] is List) {
        List<Map<String, String>> fetchedData = List<Map<String, String>>.from(
          data['data'].map((item) => {
            'deptname': item['DepartmentName'].toString(),
            'deptshortname': item['DepartmentShortName'].toString(),
            'deptcode': item['DepartmentCode'].toString(),
            // 'stid': item['EmpId'].toString(),
          }),
        );

        setState(() {
          studentList = fetchedData;
        });
      }
    }
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
        title: Text(
          'Department Details',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: studentList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  final student = studentList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        '${student['deptname']}',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      subtitle: Text(
                        'Dept Short Name: ${student['deptshortname']} \nDept Code: ${student['deptcode']}',
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
            MaterialPageRoute(builder: (context) => AddDeptPage()),
          );
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
