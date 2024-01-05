part of 'favorites_bloc.dart';

class FavoritesState {
  List<FirebaseWordModel> words;
  bool isLoading;
  String? error;

  FavoritesState({
    this.words = const [],
    this.isLoading = false,
    this.error,
  });

  FavoritesState copyWith(
          {List<FirebaseWordModel>? words, bool? isLoading, String? error}) =>
      FavoritesState(
          words: words ?? this.words,
          isLoading: isLoading ?? this.isLoading,
          error: error);
}
