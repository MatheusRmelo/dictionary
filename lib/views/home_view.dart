import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/data/enums/tab_option.dart';
import 'package:dictionary/views/widgets/tab_option_widget.dart';
import 'package:dictionary/views/word_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TabOption tab = TabOption.wordList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Row(children: [
              Expanded(
                  child: TabOptionWidget(
                onTap: () {
                  setState(() {
                    tab = TabOption.wordList;
                  });
                },
                title: 'Word list',
                isActive: TabOption.wordList == tab,
              )),
              Expanded(
                  child: TabOptionWidget(
                onTap: () {
                  setState(() {
                    tab = TabOption.history;
                  });
                },
                title: 'History',
                isActive: TabOption.history == tab,
              )),
              Expanded(
                  child: TabOptionWidget(
                onTap: () {
                  setState(() {
                    tab = TabOption.favorites;
                  });
                },
                title: 'Favorites',
                isActive: TabOption.favorites == tab,
                isLast: true,
              )),
            ]),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: PageView(
              children: const [WordListView()],
            ),
          ))
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signIn, (route) => false);
              });
            },
            child: Icon(Icons.logout)),
      ),
    );
  }
}
