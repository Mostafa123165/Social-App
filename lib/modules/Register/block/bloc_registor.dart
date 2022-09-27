import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/modules/Register/block/states_regisor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocRegisterScreen extends Cubit<RegisterState> {
  BlocRegisterScreen() : super(InitialRegisterState());

  static BlocRegisterScreen get(context) => BlocProvider.of(context);
  bool isPasswordVisibility = false;

  IconData? suffixIcon;

  void changeObscureTextPassword() {
    isPasswordVisibility = !isPasswordVisibility;
    suffixIcon = isPasswordVisibility
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeRegisterObscureTextPasswordState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              addUser(
                  phone: phone, name: name, email: email, uId: value.user!.uid,verifiedEmail: false),
            })
        .catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

   addUser(
      {required String email,
      required String uId,
      required String name,
      required String phone,
      required  bool verifiedEmail ,
      }) {
    FirebaseFirestore.instance.collection('users').doc(uId).set({
      "email": email,
      "name": name,
      "phone": phone,
      "uID" : uId ,
      "verify" : verifiedEmail ,
      "cover":"https://img.freepik.com/free-photo/aerial-view-business-team_53876-124515.jpg?w=1380&t=st=1663623156~exp=1663623756~hmac=d534f40b250365301114c23fe8113f62bb9285b8c3e08a9eba680c33c2c836ab",
      "image":"https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=1060&t=st=1663623120~exp=1663623720~hmac=f3ae65ecd5300d8ac2b05c8c25d7828d2e25e799dc8145aab9fcbc2c3b99bddb",
      "bio":"write you bio ..."
    }).then((value) {
      emit(AddUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddUserErrorState(error.toString()));
    });
  }
}
