
abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class ChangeRegisterObscureTextPasswordState extends RegisterState {}

class  RegisterLoadingState extends RegisterState {}

class  RegisterSuccessState extends RegisterState {

}

class RegisterErrorState extends RegisterState{
  final String error ;
  RegisterErrorState(this.error);
}

class  AddUserSuccessState extends RegisterState {

}

class AddUserErrorState extends RegisterState{
  final String error ;
  AddUserErrorState(this.error);
}


