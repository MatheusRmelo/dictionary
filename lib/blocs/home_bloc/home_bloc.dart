import 'package:dictionary/data/models/home_tab_model.dart';
import 'package:dictionary/views/favorites_view.dart';
import 'package:dictionary/views/history_list_view.dart';
import 'package:dictionary/views/word_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState());

  void handleClickNextPage() {
    if (state.activeTab + 1 < state.tabs.length) {
      state.pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      emit(state.copyWith(activeTab: state.activeTab + 1));
    }
  }

  void handleClickPrevPage() {
    if (state.activeTab - 1 > -1) {
      state.pageController.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      emit(state.copyWith(activeTab: state.activeTab - 1));
    }
  }

  void handleClickGoToPage(int page) {
    if (state.tabs.elementAtOrNull(page) != null) {
      state.pageController.animateToPage(page,
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      emit(state.copyWith(activeTab: page));
    }
  }
}
