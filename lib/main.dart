import 'package:firebase1/block_observer/block_observer.dart';
import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/social-screen.dart';
import 'package:firebase1/modules/login/Login_screen.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/network/local/cashHelper.dart';
import 'package:firebase1/shared/style/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  showToast(message: message.data.toString(), toastState:ToastStates.SUCCESS) ;
  print("Handling a background message: ${message.messageId}");
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  uId = CashHelper.getData(key: 'uId') ;
  print('adddddddddddddddddddddsddddddd') ;
  print(uId) ;
  var tokenDevise = await FirebaseMessaging.instance.getToken() ;
  print(tokenDevise) ;

   FirebaseMessaging.onMessage.listen((event)  // App is open and i work it
  {
    showToast(message: event.data.toString(), toastState:ToastStates.SUCCESS) ;
    print('///////////////******************00') ;
    print(event.data.toString()) ;
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event)  // App is open but i don't work it (open in background) work when i open app
  {
    showToast(message: event.data.toString(), toastState:ToastStates.SUCCESS) ;

    print(event.data.toString()) ;
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); // App is open but i don't work it (open in background)


  Widget widget ;

  if(uId != null){
    widget = const SocialScreen();
  }else {
    widget = const LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {

  final Widget? startWidget ;
   const MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SocialCubit()..getDataUser()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThem(),
        home: startWidget,
      ),
    );
  }
}
