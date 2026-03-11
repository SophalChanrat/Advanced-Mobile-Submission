class AsyncValue<T> {
  final T? data;
  final Object? error;
  final bool isLoading;

  AsyncValue.loading() : data = null, error = null, isLoading = true;
  AsyncValue.data(this.data) : error = null, isLoading = false;
  AsyncValue.eror(this.error) : data = null, isLoading = false;
}
