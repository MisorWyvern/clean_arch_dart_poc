import 'package:clean_arch_dart_poc/core/errors/failure.dart';

class RepositoryException extends Failure {
  final String message;

  RepositoryException(this.message);

  @override
  List<Object> get props => [message];
}
