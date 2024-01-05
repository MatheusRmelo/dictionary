import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/models/repository_response_model.dart';

abstract class FavoritesRepository {
  Future<RepositoryResponseModel<List<FirebaseWordModel>>> getWords();
  Future<RepositoryResponseModel<bool>> toggleFavorite(FirebaseWordModel word);
  Future<RepositoryResponseModel<bool>> isFavorite(String word);
}
