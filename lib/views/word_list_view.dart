import 'package:dictionary/blocs/word_list_bloc/word_list_bloc.dart';
import 'package:dictionary/views/widgets/tab_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordListView extends StatefulWidget {
  const WordListView({super.key});

  @override
  State<WordListView> createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  final _bloc = WordListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Word list',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: BlocBuilder<WordListBloc, WordListState>(
                bloc: _bloc,
                builder: (context, state) {
                  return GridView.builder(
                    itemCount: state.words.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        _bloc.handleClickWord(context, state.words[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            width: 0.3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            state.words[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
