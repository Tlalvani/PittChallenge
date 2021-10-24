import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'patient.dart';
import 'package:pitt_challenge/services/db.dart';
import 'patientInfo.dart';
class PatientDetail extends StatefulWidget {
  final Patient patient;

  const PatientDetail({Key key, this.patient}) : super(key: key);

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final DbService repository = DbService();
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  String name;
  String sex;
  String dob;
  String race;
  String notes;

  @override
  void initState() {
    name = widget.patient.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: double.infinity,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Patient Name',
                initialValue: widget.patient.name,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please input name';
                  }
                  return null;
                },
                inputType: TextInputType.name,
                onChanged: (value) => name = value ?? name,
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Patient Sex',
                initialValue: widget.patient.sex,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please input patient's race";
                  }
                  return null;
                },
                inputType: TextInputType.name,
                onChanged: (value) => sex = value ?? sex,
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Patient DOB',
                initialValue: widget.patient.dob,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please input patient's DOB";
                  }
                  return null;
                },
                inputType: TextInputType.datetime,
                onChanged: (value) => dob = value ?? dob,
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Patient Race',
                initialValue: widget.patient.race,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please input patient's race";
                  }
                  return null;
                },
                inputType: TextInputType.name,
                onChanged: (value) => race = value ?? race,
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'notes',
                initialValue: widget.patient.notes ?? '',
                validator: (value) {
                  return null;
                },
                inputType: TextInputType.text,
                onChanged: (value) => notes = value,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.blue.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                        repository.deletePatient(widget.patient);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )),
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () => Navigator.push<Widget>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientInfo(patient: widget.patient),
                      ),
                    ),
                    child: const Text(
                      'Access Medical Records',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),

                  ),
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();

                        widget.patient.name = name;

                        if(dob != null){
                          widget.patient.dob = dob;
                        }

                        if(sex != null){
                          widget.patient.sex = sex;
                        }

                        if(race != null){
                          widget.patient.race = race;
                        }

                        widget.patient.notes = notes ?? widget.patient.notes;

                        repository.updatePatient(widget.patient);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UserTextField extends StatelessWidget {
  const UserTextField({
    Key key,
    this.name,
    this.initialValue,
    this.inputType,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String name;
  final String initialValue;
  final TextInputType inputType;
  final String Function(String value) validator;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: inputDecoration(),
      initialValue: initialValue,
      keyboardType: inputType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  String getName(String name){
    return name == null ? "No name" : name;
  }
  InputDecoration inputDecoration() {
    return InputDecoration(
      labelText: getName(name),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2.0,
          color: Colors.lightBlue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2.0,
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
