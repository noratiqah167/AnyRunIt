import 'package:anyrunit/models/userModel.dart';
import 'package:anyrunit/net/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //utk admin delete kat stray animal
  // final FirebaseFirestore _fs = FirebaseFirestore.instance;

  // String email = "";
  String id = "";

  // Stream<Users> get authStateChanges => _firebaseAuth.idTokenChanges();

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(id: user.uid) : null;
  }

  Stream<Users> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signOut() async {
    // await _firebaseAuth.signOut();
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUp(String name, String phoneNum, String email, String password,
      String address, String lat, String long) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(id: user.uid)
          .updateUserData(name, phoneNum, email, password, address, lat, long);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpRider(String name, String phoneNum, String email,
      String password, String address, String lat, String long) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(id: user.uid)
          .updateRiderData(name, phoneNum, email, password, address, lat, long);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateProfile(String name, String phoneNum, String email,
      String password, String address, String lat, String long) async {
    try {
      id = (await _firebaseAuth.currentUser).uid;
      await DatabaseService(id: id)
          .updateUserData(name, phoneNum, email, password, address, lat, long);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateRiderProfile(String name, String phoneNum, String email,
      String password, String address, String lat, String long) async {
    try {
      id = (await _firebaseAuth.currentUser).uid;
      await DatabaseService(id: id)
          .updateRiderData(name, phoneNum, email, password, address, lat, long);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  currentUser() {}
}
