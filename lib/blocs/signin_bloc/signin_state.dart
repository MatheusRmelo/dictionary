part of 'signin_bloc.dart';

class SignInState {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isLoading;
  bool isBusy;
  bool obscureText;
  String? error;
  List<FieldErrorModel> errors;

  SignInState(
      {this.isLoading = false,
      this.isBusy = false,
      this.error,
      this.obscureText = true,
      List<FieldErrorModel>? errors,
      TextEditingController? emailController,
      TextEditingController? passwordController})
      : errors = errors ?? [],
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  SignInState copyWith(
          {List<String>? words,
          bool? isLoading,
          bool? isBusy,
          String? error,
          List<FieldErrorModel>? errors,
          bool? obscureText}) =>
      SignInState(
          emailController: emailController,
          passwordController: passwordController,
          errors: errors ?? this.errors,
          isLoading: isLoading ?? this.isLoading,
          isBusy: isBusy ?? this.isBusy,
          obscureText: obscureText ?? this.obscureText,
          error: error);
}
