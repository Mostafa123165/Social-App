
abstract class MainLoginClass {}

class InitialLoginState extends MainLoginClass{}

class SuccessLoginState extends MainLoginClass{
final String uId ;

  SuccessLoginState(this.uId);
}

class ErrorLoginState extends MainLoginClass{
  final String error ;
  ErrorLoginState(this.error);
}

class LoadingLoginState extends MainLoginClass{}

class ShowPasswordState extends MainLoginClass{}


