import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'add-pass.dart';

class PassDetail extends StatefulWidget {
  @override
  _PassDetailState createState() => _PassDetailState();
}

class _PassDetailState extends State<PassDetail> {
  List<Map<String, String>> studentList = [];

  Future<void> fetchStudentData() async {
    final response = await http.get(Uri.parse('https://reshist.me/homspwa/api/warden-pass.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] && data['data'] is List) {
        List<Map<String, String>> fetchedData = List<Map<String, String>>.from(
          data['data'].map((item) => {
            'passname': item['LeaveType'].toString(),
            'passdesc': item['Description'].toString(),
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
          'Pass Details',
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
                        '${student['passname']}',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      subtitle: Text(
                        'Description: ${student['passdesc']}',
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
            MaterialPageRoute(builder: (context) => AddPassPage()),
          );
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}


