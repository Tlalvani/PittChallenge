import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitt_challenge/services/db.dart';
import '../patientScreens/patient.dart';
import '../patientScreens/patientCard.dart';
import '../patientScreens/add_patient.dart';
class Patients extends StatelessWidget {
  @override
  final DbService repository = DbService();

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
// 3
  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 4
    final patient = Patient.fromSnapshot(snapshot);

    return PatientCard(patient: patient);
  }

  Widget build(BuildContext context) {
    void _addPatient() {
      showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const AddPatientDialog();
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPatient();
        },
        tooltip: 'Add Patient',
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
    );
  }
}



