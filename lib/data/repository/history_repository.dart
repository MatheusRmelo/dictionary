import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/models/repository_response_model.dart';

abstract class HistoryRepository {
  Future<RepositoryResponseModel<List<FirebaseWordModel>>> getWords();
  Future<RepositoryResponseModel<FirebaseWordModel>> createWord(
      FirebaseWordModel word);
}
