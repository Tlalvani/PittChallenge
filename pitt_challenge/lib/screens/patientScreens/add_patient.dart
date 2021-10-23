import 'package:flutter/material.dart';

import 'patient.dart';
import 'package:pitt_challenge/services/db.dart';

class AddPatientDialog extends StatefulWidget {
  const AddPatientDialog({Key key}) : super(key: key);

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  String patientName;
  String sex = "Male";
  String dob = "";
  String race = "";
  var _formKey = GlobalKey<FormState>();
  final DbService repository = DbService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Patient'),
        content: SingleChildScrollView(
          child: Form(
        key: _formKey,
            child: Column(
              children: <Widget>[

              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter a Patient's Full Name"),
                onChanged: (text) => patientName = text,
              ),
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Patient Sex"),
                  onChanged: (text) => sex = text,
                ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Patient's DOB"),
                onChanged: (text) => dob = text,
              ),
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Patient's Race"),
                  onChanged: (text) => race = text,
                ),
            ],
          ),
        ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                  if (patientName != null) {
                    final newPatient =
                    Patient(patientName,dob:dob,sex:sex, race:race);
                    repository.addPatient(newPatient);
                    Navigator.of(context).pop();
                  }
              },
              child: const Text('Add')),
        ]);
  }
}
