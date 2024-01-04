import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/models/field_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignUpBloc() : super(SignUpState());

  Future<void> signUp(BuildContext context) async {
    emit(state.copyWith(isBusy: true, errors: []));
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: state.emailController.text,
          password: state.passwordController.text);
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(state.nameController.text);
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      List<FieldErrorModel> errors = [];
      if (e.code == 'email-already-in-use') {
        errors.add(
            FieldErrorModel(code: 'email', message: 'E-mail já está em uso'));
      } else if (e.code == 'invalid-email') {
        errors.add(
            FieldErrorModel(code: 'email', message: 'E-mail não é válido'));
      } else if (e.code == 'weak-password') {
        errors.add(FieldErrorModel(
            code: 'password',
            message: 'Sua senha precisa ter no mínimo 6 caracteres'));
      }

      emit(state.copyWith(errors: errors, isBusy: false));
    }
  }

  void handleToggleObscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
