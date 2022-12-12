import 'dart:async';

import 'package:goosit/models/error_model.dart';
import 'package:goosit/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class AuthServiceInterface {
  Future<UserModel> getCurrentUser();
  Future<UserModel> login({required String email, required String password});
  Future<void> recoverPassword({required String email});
  Future<UserModel> register({required String email, required String password});
}

class AuthService implements AuthServiceInterface {
  @override
  Future<UserModel> getCurrentUser() {
    if (Firebase.apps.isEmpty) {
      return Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
        return getCurrentUser();
      }).catchError((error) {
        return getCurrentUser();
      });
    }
    return Future<UserModel>.microtask(() {
      return FirebaseAuth.instance.authStateChanges().first.then((user) {
        if (user == null) {
          throw ErrorModel(code: "user-not-logged", message: "User not logged");
        }
        return UserModel(id: user.uid, email: user.email!);
      });
    });
  }

  @override
  Future<UserModel> login({required String email, required String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      return UserModel(
        email: user.user!.email!,
        id: user.user!.uid,
      );
    }).catchError((error) {
      return Future<UserModel>.error(
        ErrorModel(code: error.code, message: _getErrorMessage(error)),
      );
    });
  }

  @override
  Future<void> recoverPassword({required String email}) {
    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((error) {
      return Future<void>.error(
        ErrorModel(code: error.code, message: _getErrorMessage(error)),
      );
    });
  }

  @override
  Future<UserModel> register(
      {required String email, required String password}) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      return UserModel(
        email: user.user!.email!,
        id: user.user!.uid,
      );
    }).catchError((error) {
      return Future<UserModel>.error(
        ErrorModel(code: error.code, message: _getErrorMessage(error)),
      );
    });
  }

  _getErrorMessage(error) {
    if (error.code == 'user-not-found' || error.code == 'wrong-password') {
      return "Email ou senha inválidos.";
    }
    if (error.code == 'email-already-in-use') {
      return "Email já está sendo utilizado.";
    }
    if (error.code == 'invalid-email') {
      return "Email inválido";
    }
    if (error.code == 'weak-password') {
      return "Escolha uma senha mais difícil";
    }
    return error.message;
  }
}
