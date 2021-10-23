import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitt_challenge/services/db.dart';

class Patient {
  // 1
  String name;
  String sex;
  String dob;
  String race;


  String notes;
  String referenceID;

  Patient(this.name,
      { this.sex,  this.dob, this.race, this.notes, this.referenceID});

  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final newPatient = Patient.fromJson(snapshot.data());
    newPatient.referenceID = snapshot.reference.id;
    return newPatient;
  }
  // 6
  factory Patient.fromJson(Map<String, dynamic> json) => _patientFromJson(json);
  // 7
  Map<String, dynamic> toJson() => _patientToJson(this);

  @override
  String toString() => 'Patient<$name>';
}

Patient _patientFromJson(Map<String, dynamic> json) {
  return Patient(json['name'] as String,
      sex: json['sex'] as String,
      dob: json['dob'] as String,
      race: json['race'] as String,
      notes: json['notes'] as String,
      referenceID: json['referenceID'] as String,
  );

}

Map<String, dynamic> _patientToJson(Patient instance) => <String, dynamic>{
  'name': instance.name,
  'sex': instance.sex,
  'race': instance.race,
  'dob': instance.dob,
  'notes': instance.notes,

};