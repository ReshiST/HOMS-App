
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPassPage extends StatelessWidget {
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
        title: Text('Add Pass Type', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
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
                  labelText: 'Pass Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter name of the pass' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lnameController,
                decoration: InputDecoration(
                  labelText: 'Desp',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter Description' : null,
              ),
              SizedBox(height: 10),
              // DropdownButtonFormField<String>(
              //   value: selectedDepartment,
              //   hint: Text('Select Pass Type'),
              //   onChanged: (newValue) {
              //     setState(() {
              //       selectedDepartment = newValue;
              //     });
              //   },
              //   items: departments.map((dept) {
              //     return DropdownMenuItem(
              //       child: Text(dept),
              //       value: dept,
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //   validator: (value) => value == null ? 'Please select a department' : null,
              // ),
              // SizedBox(height: 10),
              TextFormField(
                controller: mailController,
                decoration: InputDecoration(
                  labelText: 'Pass ID',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter Pass ID' : null,
              ),
              SizedBox(height: 10),
              // TextFormField(
              //   controller: numberController,
              //   decoration: InputDecoration(
              //     labelText: 'Phone Number',
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //   keyboardType: TextInputType.phone,
              //   validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
              // ),
              // SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pass added successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Add Pass', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
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