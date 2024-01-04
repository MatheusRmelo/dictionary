class RepositoryResponseModel<T> {
  T? result;
  String? error;

  RepositoryResponseModel({required this.result, this.error});
}
