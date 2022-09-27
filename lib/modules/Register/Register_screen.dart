import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/lay-out/social-screen.dart';
import 'package:firebase1/modules/Register/block/bloc_registor.dart';
import 'package:firebase1/modules/Register/block/states_regisor.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlerRegisterEmailAddress= TextEditingController() ;
    var controlerRegisterPassword= TextEditingController() ;
    var controlerRegisterName= TextEditingController() ;
    var controlerRegisterPhone= TextEditingController() ;
    var formKey = GlobalKey<FormState>() ;
    return BlocProvider(
      create: (_) => BlocRegisterScreen(),
      child: BlocConsumer<BlocRegisterScreen,RegisterState>(
        listener:(context,state) {
          if(state is AddUserSuccessState){
             navigateAndFinish(context , const SocialScreen());
          }
        },
        builder:(context,state) {
          return Scaffold(
            appBar: AppBar(elevation: 0.0,),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize:20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Register Now to shop App ',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            lapel:'User Name',
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(Icons.person),
                            controller: controlerRegisterName,
                            submitted: (value) {},
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'User name must not empty ' ;
                              }
                              return null ;
                            },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Email Address',
                          prefixIcon: const Icon(Icons.email),
                          controller: controlerRegisterEmailAddress,
                          keyboardType: TextInputType.emailAddress,
                          submitted: (value) {},
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Email Address must not empty ' ;
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          controller: controlerRegisterPassword,
                          keyboardType: TextInputType.number,
                          submitted: (value) {},
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Password is too short ' ;
                            }
                            return null ;
                          },
                          /*suffixIcon:BlocRegisterScreen.get(context).suffixIcon ,
                          onTapSuffixIcon:(){
                            BlocRegisterScreen.get(context).changeObscureTextPassword();
                          },
                          isPassword: BlocRegisterScreen.get(context).isPasswordVisibility,
                          context:context,*/
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Phone',
                          prefixIcon:const Icon(Icons.phone),
                          controller: controlerRegisterPhone,
                          keyboardType: TextInputType.phone,
                          submitted: (value) {},
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Phone must not empty' ;
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context) => defaultMaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()) {
                                  BlocRegisterScreen.get(context).userRegister(
                                    email:controlerRegisterEmailAddress.text,
                                    password: controlerRegisterPassword.text,
                                    name:  controlerRegisterName.text,
                                    phone: controlerRegisterPhone.text,
                                  );
                                }
                              },
                              text:'REGISTER',
                          ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        } ,
      ),
    );
  }
}
