import 'package:pj_barbershop_unifeob/src/core/exceptions/service_exception.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/nil.dart';
import 'package:pj_barbershop_unifeob/src/repositories/user/user_repository.dart';
import 'package:pj_barbershop_unifeob/src/services/user_register/user_register_adm_service.dart';
import 'package:pj_barbershop_unifeob/src/services/users_login/user_login_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService{
   
   final UserRepository userRepository;
   final UserLoginService userLoginService;

   UserRegisterAdmServiceImpl({
    required this.userLoginService,
    required this.userRepository
   });
   
   
   @override
   Future<Either<ServiceException, Nil>> execute(
      ({String name, String email, String password}) userData) async {
        final registerResult = await userRepository.registerAdmin(userData);

        switch(registerResult){
          case Success():
            return userLoginService.execute(userData.email, userData.password);
          case Failure(:final exception):
            return Failure(ServiceException(message: exception.message));
        }

      }
      
} 