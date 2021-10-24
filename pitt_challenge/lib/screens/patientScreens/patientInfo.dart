// Copyright (c) 2021 Razeware LLC

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom
// the Software is furnished to do so, subject to the following
// conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// Notwithstanding the foregoing, you may not use, copy, modify,
// merge, publish, distribute, sublicense, create a derivative work,
// and/or sell copies of the Software in any work that is designed,
// intended, or marketed for pedagogical or instructional purposes
// related to programming, coding, application development, or
// information technology. Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.

// This project and source code may use libraries or frameworks
// that are released under various Open-Source licenses. Use of
// those libraries and frameworks are governed by their own
// individual licenses.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'patientDetails.dart';
import 'patient.dart';
import 'package:pitt_challenge/services/db.dart';
String res = "";
class PatientInfo extends StatefulWidget {
  final Patient patient;
  PatientInfo({Key key, this.patient}) : super(key: key);

  @override
  PatientInfoState createState() => PatientInfoState();
}

class PatientInfoState extends State<PatientInfo> {
  final DbService repository = DbService();


  void createText(String key, String val){
    if(val != null && val != 'null'){
      res+=(key + ": " + val + "\n");
    }

  }

  @override
  Widget build(BuildContext context) {
    res="";
    createText("Birthplace", widget.patient.birthplace.toString());
    createText("Death Date", widget.patient.deathdate.toString());
    createText("Ethnicity", widget.patient.ethnicity.toString());
    createText("HealthCare Expenses", widget.patient.healthcare_expenses.toString());
    createText("HealthCare Coverage", widget.patient.healthcare_coverage.toString());
    createText("Body Weight", widget.patient.weight.toString());
    createText("Body Temperature", widget.patient.temp.toString());
    createText("Condition", widget.patient.condition.toString());
    createText("Allergies", widget.patient.allergies.toString());
    createText("Heart Rate", widget.patient.heartRate.toString());
    createText("Body Mass Index", widget.patient.bmi.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Records"),
        backgroundColor: Colors.blue,
      ),
        body: Center (
        child: Column(
            children: <Widget>[
              Text(
                  res,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Open Sans',
                    fontSize: 30),
              ),
            ]
          ),
        ),
    );

  }
}


