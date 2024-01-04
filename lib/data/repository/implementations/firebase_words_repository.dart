import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/data/models/repository_response_model.dart';
import 'package:dictionary/data/models/word_model.dart';
import 'package:dictionary/data/repository/words_repository.dart';

class FirebaseWordsRepository implements WordsRepository {
  final CollectionReference<WordModel> _collection = FirebaseFirestore.instance
      .collection('words')
      .withConverter<WordModel>(
        fromFirestore: (snapshot, _) => WordModel.fromJson(snapshot.data()!),
        toFirestore: (word, _) => word.toJson(),
      );
  @override
  Future<RepositoryResponseModel<List<WordModel>>> getWords() async {
    try {
      List<QueryDocumentSnapshot<WordModel>> words =
          await _collection.get().then((snapshot) => snapshot.docs);
      return RepositoryResponseModel(
          result: words.map((e) => e.data()).toList(), error: null);
    } catch (error) {
      return RepositoryResponseModel(result: null, error: error.toString());
    }
  }

  @override
  Future<RepositoryResponseModel<WordModel>> getWord(String word) {
    // TODO: implement getWord
    throw UnimplementedError();
  }
}
