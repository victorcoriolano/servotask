import 'package:help/db_service.dart';

class AuthService {
  final FirebaseService firebaseService = FirebaseService();
  AuthService();

  Future<bool> isAuthenticated() async => firebaseService.isAuthenticated();
  Future<bool> login(String email, String password) async =>
      firebaseService.login(email, password);
  Future<bool> register(String email, String password) async =>
      firebaseService.registerByEmailAndPassword(email, password);
  Future<void> logout() async => firebaseService.logOut();
}
