import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/data/models/firebase_word_model.dart';
import 'package:dictionary/data/models/repository_response_model.dart';
import 'package:dictionary/data/repository/favorites_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFavoritesRepository implements FavoritesRepository {
  final CollectionReference<FirebaseWordModel> _collection = FirebaseFirestore
      .instance
      .collection('favorites')
      .withConverter<FirebaseWordModel>(
        fromFirestore: (snapshot, _) =>
            FirebaseWordModel.fromJson(snapshot.data()!, doc: snapshot.id),
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
  Future<RepositoryResponseModel<bool>> toggleFavorite(
      FirebaseWordModel word) async {
    try {
      var result = await _collection
          .where('word', isEqualTo: word.word)
          .get()
          .then((value) => value.docs);
      bool favorite = result.isEmpty;
      if (result.isNotEmpty) {
        await _collection.doc(result.first.id).delete();
      } else {
        await _collection.add(word);
      }

      return RepositoryResponseModel(result: favorite, error: null);
    } catch (error) {
      return RepositoryResponseModel(result: null, error: error.toString());
    }
  }

  @override
  Future<RepositoryResponseModel<bool>> isFavorite(String word) async {
    try {
      var result = await _collection
          .where('word', isEqualTo: word)
          .get()
          .then((value) => value.docs);
      return RepositoryResponseModel(result: result.isNotEmpty, error: null);
    } catch (error) {
      return RepositoryResponseModel(result: null, error: error.toString());
    }
  }
}
