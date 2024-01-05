part of 'word_detail_bloc.dart';

class WordDetailState {
  WordModel? word;
  List<String> words;
  bool isLoading;
  bool isFavoriting;
  bool favorite;
  String? error;
  Duration? duration;
  Duration? position;
  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  PlayerState playerState;

  WordDetailState(
      {this.word,
      this.words = const [],
      this.isLoading = false,
      this.isFavoriting = false,
      this.favorite = false,
      this.error,
      this.duration,
      this.position,
      this.playerState = PlayerState.stopped,
      this.durationSubscription,
      this.positionSubscription,
      this.playerCompleteSubscription});

  WordDetailState copyWith(
          {WordModel? word,
          List<String>? words,
          bool? isLoading,
          bool? isFavoriting,
          bool? favorite,
          String? error,
          Duration? duration,
          PlayerState? playerState,
          Duration? position}) =>
      WordDetailState(
          words: words ?? this.words,
          word: word ?? this.word,
          isLoading: isLoading ?? this.isLoading,
          isFavoriting: isFavoriting ?? this.isFavoriting,
          favorite: favorite ?? this.favorite,
          duration: duration ?? this.duration,
          position: position ?? this.position,
          playerState: playerState ?? this.playerState,
          error: error,
          durationSubscription: durationSubscription,
          positionSubscription: positionSubscription,
          playerCompleteSubscription: playerCompleteSubscription);
}
