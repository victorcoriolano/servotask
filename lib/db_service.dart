import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help/task_model.dart';
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

  //Retorna dados do usuario
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

  //Registra a conta do usuário
  Future<bool> registerByEmailAndPassword(
    String email,
    String password,
    String inputName,
  ) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await authResult.user!.updateDisplayName(inputName);
      User? signedInUser = authResult.user;
      UserModel? localUser = userFromFirebaseUser(signedInUser);
      await addUserDetailsToFirestore(newUser: localUser);

      print('passou do signup. registrado');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Faz login na conta do usuário
  Future<bool> login(String email, String password) async {
    try {
      UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool isAuthenticated() {
    return auth.currentUser != null;
  }

  void logOut() {
    auth.signOut();
  }

  addUserDetailsToFirestore({required UserModel? newUser}) async {
    final mappedUser = newUser!.toMap();
    await firestore.collection('users').doc(newUser.uid).set(mappedUser);
  }

  Future<void> createTask(String title, String description, String uid) async {
    String? uid = auth.currentUser?.uid;

    if (uid != null || auth.currentUser!.uid != uid) {
      TaskModel newTask = TaskModel(
        title,
        description,
        todayDate,
        false,
        uid!,
      );

      await firestore.collection('tasks').add(newTask.toJson());
    } else {
      auth.currentUser!.getIdToken(true);
      return;
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('tasks')
          .orderBy('createdDate', descending: true)
          .get();
      return querySnapshot.docs.map((doc) => TaskModel.fromJson(doc)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteTask(String title) async {
    await firestore.collection('tasks').doc(title).delete();
  }
}
