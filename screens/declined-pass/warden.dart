// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
class DeclinedPass extends StatefulWidget {
  @override
  _DeclinedPassState createState() => _DeclinedPassState();
}

class _DeclinedPassState extends State<DeclinedPass> {
    List<Map<String, String>> passHistory = [];

  // Fetch pass data from API
  Future<List<Map<String, String>>> fetchPassData() async {
    final response = await http.get(Uri.parse('https://reshist.me/homspwa/api/warden-declined-pass.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        setState(() {
          passHistory = List<Map<String, String>>.from(data['data'].map((item) => {
            'studentId': item['EmpId'].toString(),
            'fullName': '${item['FirstName']} ${item['LastName']}',
            'leaveType': item['LeaveType'].toString(),
            'fromDate': item['FromDate'].toString(),
            'outTime': item['outtime'].toString(),
            'toDate': item['ToDate'].toString(),
            'inTime': item['intime'].toString(),
            'caStatus': item['castatus'].toString(),
            'hodStatus': item['hodstatus'].toString(),
            'principalStatus': item['vpstatus'].toString(),
            'appliedOn': item['PostingDate'].toString(),
            'currentStatus': item['Status'].toString(),
          }));
        });
        return passHistory;
      }
    }
    return []; // Return an empty list if API fails
  }

  // Get status text and color
  Map<String, dynamic> getStatusDetails(String status) {
    switch (status) {
      case '0': // Pending
        return {'text': 'Pending', 'color': Colors.amber[700]};
      case '1': // Approved
        return {'text': 'Approved', 'color': Colors.green};
      case '2': // Declined
        return {'text': 'Declined', 'color': Colors.red};
      case '4': // No need
        return {'text': 'No Need', 'color': Colors.blue};
      default:
        return {'text': 'Unknown', 'color': Colors.grey};
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPassData();  // Call the function to load data when the screen is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Declined Pass', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: passHistory.length,
          itemBuilder: (context, index) {
            final pass = passHistory[index];

            // Get the status details for CA, HOD, VP and Current status
            final caStatusDetails = getStatusDetails(pass['caStatus']!);
            final hodStatusDetails = getStatusDetails(pass['hodStatus']!);
            final vpStatusDetails = getStatusDetails(pass['principalStatus']!);
            final currentStatusDetails = getStatusDetails(pass['currentStatus']!);

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text('Student ID: ${pass['studentId']} - ${pass['fullName']}',
                    style: GoogleFonts.poppins(fontSize: 18)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Leave Type: ${pass['leaveType']}', style: GoogleFonts.poppins(fontSize: 14)),
                    Text('From: ${pass['fromDate']} ${pass['outTime']}', style: GoogleFonts.poppins(fontSize: 14)),
                    Text('To: ${pass['toDate']} ${pass['inTime']}', style: GoogleFonts.poppins(fontSize: 14)),
                    // CA Status
                    Text('CA Status: ${caStatusDetails['text']}',
                        style: GoogleFonts.poppins(fontSize: 14, color: caStatusDetails['color'])),
                    // HOD Status
                    Text('HOD Status: ${hodStatusDetails['text']}',
                        style: GoogleFonts.poppins(fontSize: 14, color: hodStatusDetails['color'])),
                    // Principal/VP Status
                    Text('Principal/VP Status: ${vpStatusDetails['text']}',
                        style: GoogleFonts.poppins(fontSize: 14, color: vpStatusDetails['color'])),
                    // Applied On
                    Text('Applied On: ${pass['appliedOn']}', style: GoogleFonts.poppins(fontSize: 14)),
                    // Current Status
                    Text('Current Status: ${currentStatusDetails['text']}',
                        style: GoogleFonts.poppins(fontSize: 14, color: currentStatusDetails['color'])),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}