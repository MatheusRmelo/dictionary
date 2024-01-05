import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseWordModel {
  String word;
  String userId;
  Timestamp createdAt;
  String? doc;

  FirebaseWordModel(
      {required this.word,
      required this.userId,
      required this.createdAt,
      this.doc});

  factory FirebaseWordModel.fromJson(Map<String, dynamic> json,
          {String? doc}) =>
      FirebaseWordModel(
          word: json['word'],
          userId: json['user_id'],
          createdAt: json['created_at'],
          doc: doc);

  Map<String, dynamic> toJson() =>
      {"word": word, 'user_id': userId, 'created_at': createdAt};
}
