import 'package:dictionary/data/models/field_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'recovery_password_state.dart';

class RecoveryPasswordBloc extends Cubit<RecoveryPasswordState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RecoveryPasswordBloc() : super(RecoveryPasswordState());

  Future<void> resetPassword() async {
    emit(state.copyWith(isBusy: true, errors: []));
    try {
      await _firebaseAuth.sendPasswordResetEmail(
          email: state.emailController.text);
      emit(state.copyWith(isBusy: false, hasSuccess: true));
    } on FirebaseAuthException catch (e) {
      List<FieldErrorModel> errors = [];
      // Show success to user not know if account exists in app
      if (e.code == 'user-not-found') {
        emit(state.copyWith(isBusy: false, hasSuccess: true));
        return;
      } else if (e.code == 'invalid-email') {
        errors.add(FieldErrorModel(code: 'email', message: 'E-mail inválido'));
      } else {
        errors
            .add(FieldErrorModel(code: 'email', message: 'Falha desconhecida'));
      }
      emit(state.copyWith(errors: errors, isBusy: false));
    }
  }
}
