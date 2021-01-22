import 'package:clean_arch_dart_poc/core/errors/failure.dart';

class EntityException extends Failure {
  final String message;

  EntityException(this.message);

  @override
  List<Object> get props => [message];
}
