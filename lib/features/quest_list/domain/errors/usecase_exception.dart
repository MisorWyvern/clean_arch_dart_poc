import 'package:clean_arch_dart_poc/core/errors/failure.dart';

class UseCaseException extends Failure {
  final String message;

  UseCaseException(this.message);

  @override
  List<Object> get props => [message];
}
