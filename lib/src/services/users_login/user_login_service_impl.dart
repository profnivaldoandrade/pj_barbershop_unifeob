import 'package:pj_barbershop_unifeob/src/core/constants/local_storege_keys.dart';
import 'package:pj_barbershop_unifeob/src/core/exceptions/auth_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/exceptions/service_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/nil.dart';
import 'package:pj_barbershop_unifeob/src/repositories/user/user_repository.dart';
import 'package:pj_barbershop_unifeob/src/services/users_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);
    switch (loginResult) {
      case Success(value: final idToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStoregeKeys.idToken, idToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao Efetuar o login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou Senha Iválidos'))
        };
    }
  }
}
