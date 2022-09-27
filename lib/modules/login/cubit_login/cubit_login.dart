import 'package:firebase1/modules/login/cubit_login/states_login.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/network/local/cashHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<MainLoginClass> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password, context}) {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              uId = value.user!.uid,
              print('///////////////////////////////////'),
              print(uId),
              emit(SuccessLoginState(uId!)),
            })
        .catchError((error) {
      emit(ErrorLoginState(error.toString()));
      print(error.toString());
    });
  }

  bool showPassword = true;

  void changeShowPassword() {
    showPassword = !showPassword;
    emit(ShowPasswordState());
  }
}
