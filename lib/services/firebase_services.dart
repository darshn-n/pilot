// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference products = FirebaseFirestore.instance.collection("uploads");

  CollectionReference categories =
      FirebaseFirestore.instance.collection("vehicleTypes");

  Future<void> updateUser(Map<String, dynamic> data, context) {
    return users.doc(user?.uid).update(data).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to Update',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await users.doc(user!.uid).get();
    return doc;
  }

  Future<DocumentSnapshot> getSellerData(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

  Future<void> deleteJob(String jobId) async {
    try {
      await products.doc(jobId).delete().then(
            (value) => const SnackBar(
              content: Text(
                'Deleted SuccessFully',
              ),
            ),
          );
    } catch (e) {
      const SnackBar(
        content: Text(
          'Failed to Delete',
        ),
      );
    }
  }
}
