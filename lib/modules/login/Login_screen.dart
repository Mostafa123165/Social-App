import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/lay-out/social-screen.dart';
import 'package:firebase1/modules/Register/Register_screen.dart';
import 'package:firebase1/modules/login/cubit_login/cubit_login.dart';
import 'package:firebase1/modules/login/cubit_login/states_login.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, MainLoginClass>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            showToast(
              toastState: ToastStates.ERROR,
              message: state.error,
            );
          }
          else if(state is SuccessLoginState){
            uId = state.uId ;
            CashHelper.saveData(key: 'uId', value: state.uId).then((value){

              navigateAndFinish(context , const SocialScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Login Now to Social App to speak you friends',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        defaultTextFormField(
                          lapel: "Email Address",
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null || val.toString().isEmpty) {
                              return "Email address must not empty ";
                            }
                            return null;
                          },
                          submitted: (val) {
                            if (formKey.currentState!.validate()) {}
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          lapel: "Password",
                          controller: passwordController,
                          keyboardType: TextInputType.number,
                          notShowPassword: LoginCubit.get(context).showPassword,
                          suffixIcon: IconButton(
                              onPressed: () {
                                LoginCubit.get(context).changeShowPassword();
                              },
                              icon:LoginCubit.get(context).showPassword ?  const Icon(Icons.remove_red_eye,) :  const Icon(Icons.visibility_off,)
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          validator: (val) {
                            if (val == null || val.toString().isEmpty) {
                              return "Email address must not empty ";
                            }
                            return null;
                          },
                          submitted: (val) {
                            if (formKey.currentState!.validate()) {}
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: state is! LoadingLoginState,
                            builder: (context) => defaultMaterialButton(
                                  onPressed: () {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                  text: "LOGIN",
                                ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            defaultTextButton(
                                text: 'Register',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()));
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
