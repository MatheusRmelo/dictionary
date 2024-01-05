import 'package:dictionary/blocs/recovery_password_bloc/recovery_password_bloc.dart';
import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/extensions/field_error_model_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoveryPasswordView extends StatefulWidget {
  const RecoveryPasswordView({super.key});

  @override
  State<RecoveryPasswordView> createState() => _RecoveryPasswordViewState();
}

class _RecoveryPasswordViewState extends State<RecoveryPasswordView> {
  final _bloc = RecoveryPasswordBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, Routes.signIn);
            }
          },
        ),
      ),
      body: BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
          bloc: _bloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Informe o e-mail para receber um link para redefinir sua senha",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: state.emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            border: const OutlineInputBorder(),
                            errorText: state.errors.getErrorWithCode('email'),
                            label: const Text('E-mail')),
                      ),
                      if (state.hasSuccess)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: const Text(
                            'Sucesso ao enviar e-mail',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        margin: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                            onPressed:
                                state.isBusy ? null : _bloc.resetPassword,
                            child: state.isBusy
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            style:
                                                TextStyle(color: Colors.white))
                                      ])
                                : const Text('Mudar senha')),
                      ),
                    ]),
              ),
            );
          }),
    );
  }
}
