import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/model/message_model.dart';
import 'package:firebase1/model/user-model.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {

   UserModel? userModel ;
   ChatDetailsScreen({Key? key,this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getAllMessage(receiverId: userModel!.uId) ;
        return BlocConsumer<SocialCubit , MainSocialState>(
          listener: (context , state){},
          builder: (context , state){
            var messageControler = TextEditingController() ;
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 3,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel!.image}',
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Text(
                        '${userModel!.name}'
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index ) {
                          var message = SocialCubit.get(context).message[index] ;
                          if(SocialCubit.get(context).model!.uId != message!.senderId) {
                            return senderMessage(message) ;
                          }
                          return receiveMessage(message) ;
                        },
                        separatorBuilder: (context , index )=>const SizedBox(height: 20,),
                        itemCount: SocialCubit.get(context).message.length ,
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1.0,
                          )
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: TextFormField(
                                controller: messageControler,
                                decoration: const InputDecoration(
                                  border: InputBorder.none ,
                                  hintText: "type your message...",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(text: messageControler.text, dateTime: DateTime.now().toString(), receiverId:userModel!.uId ) ;
                              },
                              child: const Icon(
                                IconBroken.Send,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  Widget receiveMessage(MessageModel message) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: defaultColor.withOpacity(0.2),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0) ,
          topEnd: Radius.circular(10.0) ,
          topStart : Radius.circular(10.0) ,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10 ,
      ),
      child: Text(
          '${message.text}'
      ),
    ),
  );
  Widget senderMessage(MessageModel message) =>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0) ,
          topEnd: Radius.circular(10.0) ,
          topStart : Radius.circular(10.0) ,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10 ,
      ),
      child: Text(
          '${message.text}'
      ),
    ),
  );
}
