// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import '../student/pass-history.dart';
import '../student/profile.dart';

class PassScreen extends StatefulWidget {
  @override
  _PassScreeneState createState() => _PassScreeneState();
}

class _PassScreeneState extends State<PassScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _outDateController = TextEditingController();
  TextEditingController _inDateController = TextEditingController();
  TextEditingController _outTimeController = TextEditingController();
  TextEditingController _inTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedLeaveType;

  final String apiUrl = 'https://reshist.me/homspwa/api/apply-leave.php';

  get http => null;

  Future<void> submitPassApplication() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'leavetype': _selectedLeaveType ?? '',
          'fromdate': _inDateController.text,
          'todate': _outDateController.text,
          'outtime': _outTimeController.text,
          'intime': _inTimeController.text,
          'description': _descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success', style: GoogleFonts.poppins()),
            content: Text(responseData['message'], style: GoogleFonts.poppins()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: GoogleFonts.poppins()),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to submit pass application');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sucess', style: GoogleFonts.poppins()),
          content: Text('Pass Submited Sucessfully!.', style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'HOMS Menu',
                style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('Pass History', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PassHistoryScreen()),
                );
              },
            ),
            ListTile(
              title: Text('My Profile', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Apply for Pass', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDateField('Out Date', _outDateController),
              _buildTimeField('Out Time', _outTimeController),
              _buildDateField('In Date', _inDateController),
              _buildTimeField('In Time', _inTimeController),
              _buildLeaveTypeDropdown(),
              _buildDescriptionField(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitPassApplication();
                  }
                },
                child: Text('Submit Pass Application', style: GoogleFonts.poppins(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context, controller),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () => _selectTime(context, controller),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a time';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLeaveTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedLeaveType,
        hint: Text('Select Leave Type'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedLeaveType = newValue;
          });
        },
        items: ['Home Pass', 'Out Pass', 'Other']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a leave type';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
    );
  }
}