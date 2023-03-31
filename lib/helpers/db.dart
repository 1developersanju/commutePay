import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseFirestore.instance;
var uid = FirebaseAuth.instance.currentUser!.uid;
var currentuser = FirebaseAuth.instance.currentUser;

updateUser(user) {
  return db.collection(uid).add(user);
}
