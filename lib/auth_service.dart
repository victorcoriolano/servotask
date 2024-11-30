import 'package:firebase_auth/firebase_auth.dart';
import 'package:help/db_service.dart';
import 'package:help/user_model.dart';

class AuthService {
  final FirebaseService firebaseService = FirebaseService();
  var auth = FirebaseAuth.instance;
  AuthService();

  UserModel? get user => firebaseService.userFromFirebaseUser(auth.currentUser);
  Future<bool> isAuthenticated() async => firebaseService.isAuthenticated();
  Future<bool> login(String email, String password) async =>
      firebaseService.login(email, password);
  Future<bool> register(
          String email, String password, String inputName) async =>
      firebaseService.registerByEmailAndPassword(email, password, inputName);
  Future<void> logout() async => firebaseService.logOut();
}
