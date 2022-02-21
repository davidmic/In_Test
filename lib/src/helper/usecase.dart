mixin UseCases<T, Params> {
  Future<T> call(Params params);
}
