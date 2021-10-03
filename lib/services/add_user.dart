import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhino_pizzeria_challenge/models/user_model.dart';

addUser(UserModel userModel, User userData, {bool? isAdmin}) async {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('users');

  userModel.uid = userData.uid;
  userModel.name = userData.displayName;
  userModel.email = userData.email;
  userModel.isAdmin = isAdmin ?? false;

  await reference.add(userModel.toMap());
}
