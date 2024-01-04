import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/models/field_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_state.dart';

class SignInBloc extends Cubit<SignInState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignInBloc() : super(SignInState());

  Future<void> signIn(BuildContext context) async {
    emit(state.copyWith(isBusy: true, errors: []));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: state.emailController.text,
          password: state.passwordController.text);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      List<FieldErrorModel> errors = [];
      if (e.code == 'user-not-found') {
        errors.add(FieldErrorModel(
            code: 'email', message: 'E-mail ou senha inválidos'));
        errors.add(FieldErrorModel(
            code: 'password', message: 'E-mail ou senha inválidos'));
      } else if (e.code == 'wrong-password') {
        errors.add(FieldErrorModel(
            code: 'email', message: 'E-mail ou senha inválidos'));
        errors.add(FieldErrorModel(
            code: 'password', message: 'E-mail ou senha inválidos'));
      } else if (e.code == 'invalid-email') {
        errors.add(
            FieldErrorModel(code: 'email', message: 'E-mail não é válido'));
      } else if (e.code == 'too-many-requests') {
        errors.add(
            FieldErrorModel(code: 'general', message: 'Muitas requisições'));
      } else {
        errors.add(
            FieldErrorModel(code: 'general', message: 'Falha desconhecida'));
      }
      emit(state.copyWith(errors: errors, isBusy: false));
    }
  }

  void handleToggleObscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
