import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/model/user-model.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textUserPost = TextEditingController() ;
    var dateTime = DateTime.now() ;
    return BlocConsumer<SocialCubit, MainSocialState>(
      listener: (context, state){},
      builder: (context , state){
        var posImage = SocialCubit.get(context).postImage;
        return  Scaffold(
          appBar: defaultAppar(
            context: context,
            title: "Create Post",
            action: [
              TextButton(
                  onPressed: (){
                    if(SocialCubit.get(context).postImage != null){
                      SocialCubit.get(context).uploadPostImage(text: textUserPost.text, dateTime: dateTime.toString() ,context: context );

                    }else {
                      SocialCubit.get(context).createPost(text: textUserPost.text, dateTime: dateTime.toString() ,context: context );
                    }
                  },
                  child: const Text(
                      'Post' ,
                  ),
              ),
            ],
            onPressed: (){
              SocialCubit.get(context).removePostImage();
              Navigator.pop(context);
            }
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is GetPostImagePostLoadingState)
                    const LinearProgressIndicator() ,
                  if(state is GetPostImagePostLoadingState)
                    SizedBox(height: 12,),
                  Row(
                    children: [
                       CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).model!.image}'),
                        radius: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Mostafa Tarek',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                      height: 1,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Icon(
                                  Icons.check_circle,
                                  size: 16.0,
                                  color: defaultColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText:"What is your mind, ${SocialCubit.get(context).model!.name}"
                    ),
                    controller: textUserPost,
                    keyboardType: TextInputType.multiline,

                    maxLines: null  ,
                  ),
                  const SizedBox(height: 20,),
                  if(posImage != null)
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                            height: 450,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.0,
                                ),
                                image: DecorationImage(
                                  image: FileImage(posImage) ,
                                  fit: BoxFit.cover,
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 16,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostImage() ;
                                },
                                icon: Icon(
                                  Icons.clear,
                                  size: 16,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  if(posImage != null)
                  const SizedBox(height: 25,),
                  if(posImage == null)
                    SizedBox(height: 250,) ,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            SocialCubit.get(context).getPostImage() ;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                                color: Colors.blue,
                              ),
                              Text(
                                'add Photo' ,
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '#tags' ,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
