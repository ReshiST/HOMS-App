// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AddDeptPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String? selectedDepartment;
  final List<String> departments = ['Information Technology', 'Computer Science', 'Electronics', 'Mechanical'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Department', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: fnameController,
                decoration: InputDecoration(
                  labelText: 'Department Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter name of the Department' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lnameController,
                decoration: InputDecoration(
                  labelText: 'Department Code',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter Code of the Department' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: mailController,
                decoration: InputDecoration(
                  labelText: 'Mail ID',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter Mail ID' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'HoD\'s Mobile Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter Mobile Number' : null,
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Department added successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Add Department', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
  
  void setState(Null Function() param0) {}
}
