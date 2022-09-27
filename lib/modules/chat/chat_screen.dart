import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/model/user-model.dart';
import 'package:firebase1/modules/caht_details/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , MainSocialState>(
      listener: (context, state){},
      builder: (context, state){
        return  ConditionalBuilder(
          condition: SocialCubit.get(context).users!.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context , index) =>buildItems(context , SocialCubit.get(context).users![index]),
            separatorBuilder: (context , index)=>SizedBox(height: 5,),
            itemCount: SocialCubit.get(context).users!.length ,
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator()) ,

        ) ;
      },
    );
  }

  Widget buildItems(context ,UserModel model ) => InkWell(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
            radius: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => ChatDetailsScreen(userModel: model,)));
    },
  ) ;
}
