sealed class Resource<T> {
  final T? data;
  final String? message;

  const Resource({this.data, this.message});
}

class Success<T> extends Resource<T> {
  const Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  const Error(String message, {super.data}) : super(message: message);
}

class Loading<T> extends Resource<T> {
  const Loading({super.data}) : super();
}
