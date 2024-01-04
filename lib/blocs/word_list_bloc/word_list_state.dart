part of 'word_list_bloc.dart';

class WordListState {
  List<String> words;
  bool isLoading;
  String? error;

  WordListState({
    this.words = const [],
    this.isLoading = false,
    this.error,
  });

  WordListState copyWith(
          {List<String>? words, bool? isLoading, String? error}) =>
      WordListState(
          words: words ?? this.words,
          isLoading: isLoading ?? this.isLoading,
          error: error);
}
