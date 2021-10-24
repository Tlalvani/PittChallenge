import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/patientScreens/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pitt_challenge/services/authFB.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
class DbService{

  final String uid;
  DbService({this.uid});
  final CollectionReference doctorData = FirebaseFirestore.instance.collection('Professionals');

  String UID = (_auth.currentUser.uid);
  String output = "Loading...";

  Future inputChatbot(String input) async {
    print(UID);
    return await doctorData.doc(UID).collection('Chatbot').doc('Command').set({
      'Input': input,
      'Output': null,
    });
  }

  String getUID() {
    return UID;
  }
  Stream<QuerySnapshot> getStream() {
    return doctorData.doc(UID).collection('Patients').snapshots();
  }

  Future<DocumentReference> addPatient(Patient patient) {
    return doctorData.doc(UID).collection('Patients').add(patient.toJson());
  }

  void updatePatient(Patient patient) async {
    await doctorData.doc(UID).collection('Patients').doc(patient.referenceID).update(patient.toJson());
  }

  void deletePatient(Patient patient) async {
    await doctorData.doc(UID).collection('Patients').doc(patient.referenceID).delete();
  }

  Stream<DocumentSnapshot>provideDocumentFieldStream(Patient patient){
    return doctorData.doc(UID).collection('Patients').doc(patient.referenceID).snapshots();
  }

}

