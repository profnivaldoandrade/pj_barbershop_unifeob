sealed class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic>json){
    return switch(json['role']){
      1 => UserModelADM.fromMap(json),
      0 => UserModelEmployee.fromMap(json),
      _=> throw ArgumentError('User rote not faund') 
    };
  }
}

class UserModelADM extends UserModel {
  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String name,
        "email": String email,
      } =>
        UserModelADM(
          id: id,
          name: name,
          email: email,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class UserModelEmployee extends UserModel {
  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
  });
  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String name,
        "email": String email,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
