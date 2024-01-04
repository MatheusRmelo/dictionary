class WordMeaningModel {
  String partOfSpeech;
  String definition;

  WordMeaningModel({required this.partOfSpeech, required this.definition});

  factory WordMeaningModel.fromJson(Map<String, dynamic> json) {
    List definitions = (json['definitions'] as List);
    return WordMeaningModel(
        definition: definitions.isNotEmpty
            ? definitions.first['definition']
            : "Não encontrado",
        partOfSpeech: json['partOfSpeech']);
  }
}
