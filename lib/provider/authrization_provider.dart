import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/main.dart';
import 'package:movie_recommendation_app/models/user_model.dart';

class AuthrizationProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
  bool loading = false;

  Future <bool> login (String email, String password) async {
    showLoading(true);
    try {
      await auth.signInWithEmailAndPassword (email: email.trim(), password: password.trim());
      return true;
    } 
    on FirebaseAuthException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
      return false;
    }  
    catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future <bool> signUp (String name, String email, String password) async {
    showLoading(true);
    try {
      final result = await auth.createUserWithEmailAndPassword (email: email.trim(), password: password.trim());
      UserModel user = UserModel (result.user!.uid, name, email);
      await database.collection("user").doc(result.user!.uid).set(user.toMap());
      return true;
    } on FirebaseAuthException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
      return false;
    } 
    catch (e) {
     scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future <bool> forgotPassword (String email) async {
    showLoading(true);
    try {
      await auth.sendPasswordResetEmail(email: email.trim());
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text("Please check your email for the password reset link."),
        backgroundColor: Colors.green,
      ));
      return true;
    } on FirebaseAuthException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    } 
    catch (e) {
     scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future <void> logout () async {
    showLoading(true);
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } 
    catch (e) {
     scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showLoading(false);
    }
  }

  showLoading (bool value) {
    loading = value;
    notifyListeners();
  }
}