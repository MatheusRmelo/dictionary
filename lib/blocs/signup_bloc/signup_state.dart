part of 'signup_bloc.dart';

class SignUpState {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isBusy;
  bool obscureText;
  String? error;
  List<FieldErrorModel> errors;

  SignUpState(
      {this.isBusy = false,
      this.error,
      this.obscureText = true,
      List<FieldErrorModel>? errors,
      TextEditingController? nameController,
      TextEditingController? emailController,
      TextEditingController? passwordController})
      : errors = errors ?? [],
        nameController = nameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  SignUpState copyWith(
          {List<String>? words,
          bool? isBusy,
          String? error,
          List<FieldErrorModel>? errors,
          bool? obscureText}) =>
      SignUpState(
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          errors: errors ?? this.errors,
          isBusy: isBusy ?? this.isBusy,
          obscureText: obscureText ?? this.obscureText,
          error: error);
}
