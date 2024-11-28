import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help/user_model.dart';

class FirebaseService {
  FirebaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthStateChanges {
    return auth.authStateChanges();
  }

  User? get currentUser {
    if (auth.currentUser == null) return null;
    return auth.currentUser;
  }

  String todayDate =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  UserModel? userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            name: user.displayName!,
            email: user.email!,
            uid: user.uid,
            creationDate: todayDate,
            token: user.refreshToken)
        : null;
  }

  Future<bool> registerByEmailAndPassword(
      String inputName, String email, String password) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? signedInUser = authResult.user;
      authResult.user!.updateDisplayName(inputName);

      //cria um user model temporario para uid de acordo com a nova conta criada
      UserModel? localUser = userFromFirebaseUser(signedInUser);

      //verifica se ele é válido, seta os estados de auth e cria o user no db
      if (signedInUser != null && localUser!.uid != null) {
        print('passou do if NOT NULL do sign up');
        //atualização da model temporaria
        await signedInUser.updateProfile(
            displayName: inputName);
        //cria o user no db
        await dbService.addUserDetailsToFirestore(newUser: _localUser!);
        print('passou do signup');
        return true;
      }
      print('the user returned null. error occurred');
      return false;
    } catch (e) {
      print(e);
      _localUser!.authEnumState = AuthEnumState.notLoggedIn;
      return false;
    }
  }

  login(String email, String password) {}
  isAuthenticated() {}
  void logOut() {}
}
