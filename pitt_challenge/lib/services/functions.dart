import 'package:cloud_functions/cloud_functions.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class CloudFunction{
  void sendUID(String uid) async {
    try{
      final results = await FirebaseFunctions.instance.httpsCallable('function-1').call(<String, dynamic>{
        "uid":uid,
      });
    }catch(error){
      print(error.toString());
    }
  }
}