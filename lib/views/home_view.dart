import 'package:dictionary/blocs/home_bloc/home_bloc.dart';
import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/enums/tab_option.dart';
import 'package:dictionary/views/widgets/tab_option_widget.dart';
import 'package:dictionary/views/word_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
            bloc: _bloc,
            builder: (context, state) {
              return Column(children: [
                Container(
                  height: 48,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  color: Colors.white,
                  child: Row(
                      children: state.tabs
                          .asMap()
                          .entries
                          .map((e) => Expanded(
                                  child: TabOptionWidget(
                                title: e.value.title,
                                isActive: state.activeTab == e.key,
                                onTap: () {
                                  _bloc.handleClickGoToPage(e.key);
                                },
                                isLast: e.key == state.tabs.length - 1,
                              )))
                          .toList()),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: PageView(
                    controller: state.pageController,
                    children: state.tabs.map((e) => e.view).toList(),
                  ),
                ))
              ]);
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signIn, (route) => false);
              });
            },
            child: const Icon(Icons.logout)),
      ),
    );
  }
}
