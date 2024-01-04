import 'package:dictionary/data/models/repository_response_model.dart';
import 'package:dictionary/data/models/word_model.dart';

abstract class WordsRepository {
  Future<RepositoryResponseModel<WordModel>> getWord(String word);
}
