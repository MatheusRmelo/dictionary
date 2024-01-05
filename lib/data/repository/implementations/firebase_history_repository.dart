import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/models/repository_response_model.dart';
import 'package:dictionary/data/models/word_model.dart';
import 'package:dictionary/data/repository/history_repository.dart';
import 'package:dictionary/data/repository/words_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHistoryRepository implements HistoryRepository {
  final CollectionReference<FirebaseWordModel> _collection = FirebaseFirestore
      .instance
      .collection('histories')
      .withConverter<FirebaseWordModel>(
        fromFirestore: (snapshot, _) =>
            FirebaseWordModel.fromJson(snapshot.data()!),
        toFirestore: (word, _) => word.toJson(),
      );
  @override
  Future<RepositoryResponseModel<List<FirebaseWordModel>>> getWords() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return RepositoryResponseModel(
          result: null, error: 'Usuário não autenticado');
    }
    try {
      List<QueryDocumentSnapshot<FirebaseWordModel>> words = await _collection
          .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('created_at', descending: true)
          .get()
          .then((snapshot) => snapshot.docs);
      return RepositoryResponseModel(
          result: words.map((e) => e.data()).toList(), error: null);
    } catch (error) {
      return RepositoryResponseModel(result: null, error: error.toString());
    }
  }

  @override
  Future<RepositoryResponseModel<FirebaseWordModel>> createWord(
      FirebaseWordModel word) async {
    try {
      var response = await _collection.add(word);
      return RepositoryResponseModel(
          result: (await response.get()).data(), error: null);
    } catch (error) {
      return RepositoryResponseModel(result: null, error: error.toString());
    }
  }
}
