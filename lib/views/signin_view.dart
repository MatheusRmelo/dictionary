import 'package:dictionary/blocs/signin_bloc/signin_bloc.dart';
import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/extensions/field_error_model_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _bloc = SignInBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: null, elevation: 0, backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SignInBloc, SignInState>(
              bloc: _bloc,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bem vindo ao Dictionary",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Entre agora e descubra novas palavras",
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 24,
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
                          margin: const EdgeInsets.only(top: 4),
                          height: 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Esqueci minha senha",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          margin: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                              onPressed: state.isBusy
                                  ? null
                                  : () {
                                      _bloc.signIn(context);
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
                                  : const Text('Entrar')),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signUp);
                              },
                              child: const Text(
                                "Não tem conta ainda? Crie uma agora!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ]),
                );
              }),
        ));
  }
}
