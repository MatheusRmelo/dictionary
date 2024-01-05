import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/repository/history_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'history_list_state.dart';

class HistoryListBloc extends Cubit<HistoryListState> {
  final HistoryRepository _repository = GetIt.I<HistoryRepository>();
  HistoryListBloc() : super(HistoryListState());

  Future<void> getWords() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.getWords();
    emit(state.copyWith(
        words: response.result, isLoading: false, error: response.error));
  }

  void handleClickWord(BuildContext context, String word) {
    Navigator.pushNamed(context, '/details', arguments: {
      'word': word,
      'words': state.words.map((e) => e.word).toList()
    }).then((value) {
      getWords();
    });
  }
}
