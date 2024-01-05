import 'package:dictionary/blocs/history_list_bloc/history_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _bloc = HistoryListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getWords();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'History',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: BlocBuilder<HistoryListBloc, HistoryListState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.error != null) {
                    return Center(
                      child: Column(
                        children: [
                          const Text(
                            'FALHA',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.error!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.red),
                          ),
                          ElevatedButton(
                              onPressed: _bloc.getWords,
                              child: const Text('Tentar novamente'))
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    itemCount: state.words.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        _bloc.handleClickWord(context, state.words[index].word);
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
                            state.words[index].word,
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
