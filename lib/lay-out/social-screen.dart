import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, MainSocialState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context) ;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            elevation: 0.0,
            title:  Text(
              SocialCubit.get(context).title[SocialCubit.get(context).currentIndex],
              style: const TextStyle(
                color: Colors.black,
              )
            ),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){
              }, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              SocialCubit.get(context).changeBottomNav(index,context);
            },
            currentIndex: SocialCubit.get(context).currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label:'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label:'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Upload),
                  label:'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.User),
                label:'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label:'setting'
              ),
            ],
          ),
        );
      },
    );
  }
}
