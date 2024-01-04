import 'package:dictionary/blocs/signin_bloc/signin_bloc.dart';
import 'package:dictionary/blocs/signup_bloc/signup_bloc.dart';
import 'package:dictionary/data/extensions/field_error_model_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: null, elevation: 0, backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SignUpBloc, SignUpState>(
              bloc: _bloc,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Crie sua conta no Dictionary",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "E comece aprender novas palavras",
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: state.nameController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              border: const OutlineInputBorder(),
                              errorText: state.errors.getErrorWithCode('name'),
                              label: const Text('Nome completo')),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: state.emailController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              border: const OutlineInputBorder(),
                              errorText: state.errors.getErrorWithCode('email'),
                              label: const Text('E-mail')),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: state.passwordController,
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              errorText:
                                  state.errors.getErrorWithCode('password'),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscureText
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                                onPressed: _bloc.handleToggleObscureText,
                              ),
                              label: const Text('Senha')),
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          margin: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                              onPressed: state.isBusy
                                  ? null
                                  : () {
                                      _bloc.signUp(context);
                                    },
                              child: state.isBusy
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text("Carregando...",
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ])
                                  : const Text('Criar conta')),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Já tem conta? Entre agora!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ]),
                );
              }),
        ));
  }
}
