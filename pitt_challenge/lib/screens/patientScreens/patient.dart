import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitt_challenge/services/db.dart';

class Patient {
  // 1
  String name;
  String sex;
  String dob;
  String race;
  String bmi;
  String birthplace;
  String deathdate;
  String ethnicity;
  String healthcare_expenses;
  String healthcare_coverage;
  String condition;
  String allergies;
  String weight;
  String height;
  String temp;
  String heartRate;


  String notes;
  String referenceID;

  Patient(this.name,
      { this.sex,  this.dob, this.race, this.notes, this.referenceID, this.bmi, this.birthplace, this.deathdate, this.ethnicity, this.healthcare_expenses, this.healthcare_coverage,
        this.condition, this.allergies, this.weight, this.height, this.temp, this.heartRate});

  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final newPatient = Patient.fromJson(snapshot.data());
    newPatient.referenceID = snapshot.reference.id;
    return newPatient;
  }

  factory Patient.fromJson(Map<String, dynamic> json) => _patientFromJson(json);

  Map<String, dynamic> toJson() => _patientToJson(this);

  @override
  String toString() => 'Patient<$name>';
}

Patient _patientFromJson(Map<String, dynamic> json) {
  return Patient(json['name'] as String,
      sex: json['sex'] as String,
      dob: json['birthdate'] as String,
      race: json['race'] as String,
      notes: json['notes'] as String,
      referenceID: json['referenceID'] as String,
      bmi : json['body mass index'] as String,
      birthplace: json['birthplace'] as String,
      ethnicity: json['ethnicity'] as String,
      healthcare_expenses: json['healthcare_expenses'] as String,
      healthcare_coverage: json['healthcare_coverage'] as String,
      condition: json['condition'] as String,
      allergies: json['allergies'] as String,
      weight : json['body weight'] as String,
      temp: json['body temperature'] as String,
      heartRate: json['heart rate'] as String,
  );

}

Map<String, dynamic> _patientToJson(Patient instance) => <String, dynamic>{
  'name': instance.name,
  'sex': instance.sex,
  'race': instance.race,
  'birthdate': instance.dob,
  'notes': instance.notes,

};