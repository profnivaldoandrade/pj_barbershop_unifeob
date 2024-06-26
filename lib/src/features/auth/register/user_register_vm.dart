import 'package:asyncstate/asyncstate.dart';
import 'package:pj_barbershop_unifeob/src/core/fp/either.dart';
import 'package:pj_barbershop_unifeob/src/core/providers/application_providers.dart';
import 'package:pj_barbershop_unifeob/src/features/auth/register/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus{
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm{
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial; 

  Future<void>register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);
    
    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final registerResult = await userRegisterAdmService.execute(userData).asyncLoader();
    switch(registerResult){
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }

  }
}