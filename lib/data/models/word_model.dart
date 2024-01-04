import 'package:dictionary/data/models/word_meaning_model.dart';

class WordModel {
  String word;
  String phonetic;
  String audioUrl;
  List<WordMeaningModel> meanings;

  WordModel(
      {required this.word,
      required this.phonetic,
      required this.audioUrl,
      this.meanings = const []});

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
      word: json['word'],
      phonetic: json['phonetic'],
      audioUrl: (json['phonetics'] as List).first['audio'],
      meanings: (json['meanings'] as List)
          .map((e) => WordMeaningModel.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {"word": word};
}
