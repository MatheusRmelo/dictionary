part of 'history_list_bloc.dart';

class HistoryListState {
  List<FirebaseWordModel> words;
  bool isLoading;
  String? error;

  HistoryListState({
    this.words = const [],
    this.isLoading = false,
    this.error,
  });

  HistoryListState copyWith(
          {List<FirebaseWordModel>? words, bool? isLoading, String? error}) =>
      HistoryListState(
          words: words ?? this.words,
          isLoading: isLoading ?? this.isLoading,
          error: error);
}
