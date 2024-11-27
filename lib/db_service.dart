import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  isAuthenticated() {}
  login(String email, String password) {}
  registerByEmailAndPassword(String email, String password) {}
  void logOut() {}
}
