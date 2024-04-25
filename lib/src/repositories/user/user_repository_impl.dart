import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pj_barbershop_unifeob/src/core/exceptions/auth_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/exceptions/repository_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/nil.dart';
import 'package:pj_barbershop_unifeob/src/models/user_model.dart';
import 'package:pj_barbershop_unifeob/src/repositories/user/user_repository.dart';
import 'package:pj_barbershop_unifeob/src/core/restClient/rest_client.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.auth.post('/login', data: {
        'email': email,
        'password': password,
      });
      return Success(data['token']);
      //throw UnimplementedError();
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou Senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao efetuar o login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: e.message),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'role': 1
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar o usuário admin', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao registrar o usuário admin'),
      );
    }
  }
}
