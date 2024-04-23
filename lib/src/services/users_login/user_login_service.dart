import 'package:pj_barbershop_unifeob/src/core/exceptions/service_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/nil.dart';

abstract interface class UserLoginService{
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}