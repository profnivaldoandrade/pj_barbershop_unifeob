import 'package:pj_barbershop_unifeob/src/core/exceptions/auth_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/exceptions/repository_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/nil.dart';
import 'package:pj_barbershop_unifeob/src/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String email, String password}) userData);
}
