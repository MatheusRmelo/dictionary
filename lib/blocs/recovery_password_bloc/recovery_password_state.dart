part of 'recovery_password_bloc.dart';

class RecoveryPasswordState {
  TextEditingController emailController;
  bool isBusy;
  String? error;
  List<FieldErrorModel> errors;
  bool hasSuccess;

  RecoveryPasswordState(
      {this.isBusy = false,
      this.hasSuccess = false,
      this.error,
      List<FieldErrorModel>? errors,
      TextEditingController? emailController})
      : errors = errors ?? [],
        emailController = emailController ?? TextEditingController();

  RecoveryPasswordState copyWith(
          {List<String>? words,
          bool? hasSuccess,
          bool? isBusy,
          String? error,
          List<FieldErrorModel>? errors,
          bool? obscureText}) =>
      RecoveryPasswordState(
          emailController: emailController,
          hasSuccess: hasSuccess ?? this.hasSuccess,
          errors: errors ?? this.errors,
          isBusy: isBusy ?? this.isBusy,
          error: error);
}
