import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_state.freezed.dart';

enum AuthorOperation {
  createAuthor,
  getAuthors,
  getAuthorById,
  updateAuthorById,
  deleteAuthorById
}

@freezed
class AuthorState<T> with _$AuthorState<T> {
  const factory AuthorState.idle() = _Idle<T>;

  const factory AuthorState.loading({
    required AuthorOperation operation,
  }) = _Loading<T>;

  const factory AuthorState.response({
    required AuthorOperation operation,
    required T data,
  }) = _Response<T>;

  const factory AuthorState.error({
    required AuthorOperation operation,
    required String message,
  }) = _Error<T>;
}
