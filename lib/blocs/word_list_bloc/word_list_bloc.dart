import 'package:dictionary/constants/words.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_list_state.dart';

class WordListBloc extends Cubit<WordListState> {
  WordListBloc() : super(WordListState());

  void init() {
    var newWords = words;
    newWords.shuffle();
    emit(state.copyWith(words: newWords));
  }

  void handleClickWord(BuildContext context, String word) {
    Navigator.pushNamed(context, '/details',
        arguments: {'word': word, 'words': state.words});
  }
}
