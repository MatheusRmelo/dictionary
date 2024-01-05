import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/models/word_model.dart';
import 'package:dictionary/data/repository/favorites_repository.dart';
import 'package:dictionary/data/repository/history_repository.dart';
import 'package:dictionary/data/repository/words_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
part 'word_detail_state.dart';

class WordDetailBloc extends Cubit<WordDetailState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final HistoryRepository _historyRepository = GetIt.I<HistoryRepository>();
  final FavoritesRepository _favoritesRepository =
      GetIt.I<FavoritesRepository>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final WordsRepository _repository = GetIt.I<WordsRepository>();
  WordDetailBloc() : super(WordDetailState());

  Future<void> getWord(String word) async {
    emit(state.copyWith(isLoading: true));
    _saveWord(word);
    await getIsFavorite(word);
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

  Future<void> getIsFavorite(String word) async {
    var response = await _favoritesRepository.isFavorite(word);
    emit(state.copyWith(error: response.error, favorite: response.result));
  }

  Future<void> toggleFavorite() async {
    if (state.word == null) return;
    emit(state.copyWith(isFavoriting: true));
    var response = await _favoritesRepository.toggleFavorite(FirebaseWordModel(
        word: state.word!.word,
        userId: _firebaseAuth.currentUser!.uid,
        createdAt: Timestamp.fromDate(DateTime.now())));
    emit(state.copyWith(
        isFavoriting: false, favorite: response.result, error: response.error));
  }

  void handleClickPlayerSong() {
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

  void _saveWord(String word) {
    if (_firebaseAuth.currentUser == null) return;
    _historyRepository.createWord(FirebaseWordModel(
        word: word,
        userId: _firebaseAuth.currentUser!.uid,
        createdAt: Timestamp.fromDate(DateTime.now())));
  }
}
