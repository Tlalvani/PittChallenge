import 'package:flutter/material.dart';
import 'patient.dart';
import 'patientRoom.dart';
class PatientCard extends StatelessWidget {
  final Patient patient;
  final TextStyle boldStyle;


   PatientCard({Key key, this.patient, this.boldStyle})
      : super(key: key);

   String getName(){
     return patient.name == null ? "No Name" : patient.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(getName(), style: boldStyle),
            ),
          ),
          _getPatientIcon()
        ],
      ),
      onTap: () => Navigator.push<Widget>(
        context,
        MaterialPageRoute(
          builder: (context) => PatientRoom(patient: patient),
        ),
      ),
      splashColor: Colors.blue[100],
    ));
  }

  Widget _getPatientIcon() {
    Widget patientIcon;
      patientIcon = IconButton(
        icon: const Icon((Icons.person), color: Colors.blueGrey,),
        onPressed: () {},
      );
    return patientIcon;
  }
}
