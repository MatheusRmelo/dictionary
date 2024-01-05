part of 'home_bloc.dart';

class HomeState {
  int activeTab;
  PageController pageController;
  final List<HomeTabModel> tabs = [
    HomeTabModel(title: 'Word List', view: const WordListView()),
    HomeTabModel(title: 'History', view: const HistoryListView()),
    HomeTabModel(title: 'Favorites', view: const FavoritesView()),
  ];

  HomeState({this.activeTab = 0, PageController? pageController})
      : pageController = pageController ?? PageController();
  HomeState copyWith({int? activeTab}) => HomeState(
      activeTab: activeTab ?? this.activeTab, pageController: pageController);
}
