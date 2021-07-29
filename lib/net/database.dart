import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String id;

  DatabaseService({this.id});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String name, String phoneNum, String email,
      String password, String address, String lat, String long) async {
    return await userCollection.doc(id).set({
      'Name': name,
      'Phone Number': phoneNum,
      'Email': email,
      'Password': password,
      'Address': address,
      'Role': 'User',
      "UserId": id,
      "Latt": lat,
      "Longg": long
    });
  }

  Future updateRiderData(String name, String phoneNum, String email,
      String password, String address, String lat, String long) async {
    return await userCollection.doc(id).set({
      'Name': name,
      'Phone Number': phoneNum,
      'Email': email,
      'Address': address,
      'Password': password,
      'Role': 'Rider',
      "UserId": id,
      "Latt": lat,
      "Longg": long
    });
  }
}
