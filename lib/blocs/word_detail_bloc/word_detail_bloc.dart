import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/data/models/word_model.dart';
import 'package:dictionary/data/repository/implementations/free_dictionary_repository.dart';
import 'package:dictionary/data/repository/words_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'word_detail_state.dart';

class WordDetailBloc extends Cubit<WordDetailState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final WordsRepository _repository = FreeDictionaryRepository();
  WordDetailBloc() : super(WordDetailState());

  Future<void> getWord(String word) async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.getWord(word);
    if (response.result != null && response.result!.audioUrl.isNotEmpty) {
      await audioPlayer.setSourceUrl(response.result!.audioUrl);
      audioPlayer
          .getDuration()
          .then((value) => emit(state.copyWith(duration: value)));
      audioPlayer
          .getCurrentPosition()
          .then((value) => emit(state.copyWith(position: value)));
      emit(state.copyWith(playerState: audioPlayer.state));
      _initStreamsAudio();
    }
    emit(state.copyWith(
        error: response.error, word: response.result, isLoading: false));
  }

  Future<void> handleClickPlayerSong() async {
    audioPlayer.play(UrlSource(state.word!.audioUrl));
  }

  void setWords(List<String> words) {
    emit(state.copyWith(words: words));
  }

  void _initStreamsAudio() {
    state.durationSubscription =
        audioPlayer.onDurationChanged.listen((duration) {
      emit(state.copyWith(duration: duration));
    });

    state.positionSubscription =
        audioPlayer.onPositionChanged.listen((position) {
      emit(state.copyWith(position: position));
    });

    state.playerCompleteSubscription =
        audioPlayer.onPlayerComplete.listen((event) {
      emit(state.copyWith(
          playerState: PlayerState.stopped, position: Duration.zero));
    });
  }

  void handleClickBack() {
    int index =
        state.words.indexWhere((element) => element == state.word!.word);
    if (index > -1) {
      if (index - 1 > -1) getWord(state.words[index - 1]);
    }
  }

  void handleClickNext() {
    int index =
        state.words.indexWhere((element) => element == state.word!.word);
    if (index > -1) {
      if (index + 1 < state.words.length) getWord(state.words[index + 1]);
    }
  }
}
