import 'package:dictionary/data/models/field_error_model.dart';

extension FieldErrorModelExtension on List<FieldErrorModel> {
  String? getErrorWithCode(String code) {
    int index = indexWhere((element) => element.code == code);
    if (index == -1) return null;
    return this[index].message;
  }
}
