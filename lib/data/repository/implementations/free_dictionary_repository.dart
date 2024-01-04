import 'dart:convert';

import 'package:dictionary/data/models/repository_response_model.dart';
import 'package:dictionary/data/models/word_model.dart';
import 'package:dictionary/data/repository/words_repository.dart';
import 'package:http/http.dart' as http;

class FreeDictionaryRepository implements WordsRepository {
  final String _path = "https://api.dictionaryapi.dev/api/v2/entries/en";
  @override
  Future<RepositoryResponseModel<WordModel>> getWord(String word) async {
    var response = await http.get(Uri.parse("$_path/$word"));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as List;
      if (result.isNotEmpty) {
        return RepositoryResponseModel(
            result: WordModel.fromJson(result.first));
      }
    }
    return RepositoryResponseModel(
        result: null, error: 'Falha ao buscar palavra');
  }
}
