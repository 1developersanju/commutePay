import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreStreamProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUserDataStream(String uid, String phoneNumber) {
    return _firestore
        .collection("users")
        // .doc(uid)
        .doc(phoneNumber)
        .snapshots();
  }

  Stream getDataStream(String uid, String phoneNumber) {
    return _firestore
        .collection("users")
        // .doc(uid)
        .doc(phoneNumber)
        .snapshots();
  }
}
