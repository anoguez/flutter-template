import 'package:equatable/equatable.dart';
import 'package:flutter_template/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
