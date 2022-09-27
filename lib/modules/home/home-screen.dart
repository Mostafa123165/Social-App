import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, MainSocialState>(
      listener: (context, state) => {
        if(state is CreatePostSuccessState){
          showToast(message: "Create post success",toastState: ToastStates.SUCCESS)
        }
      },
      builder: (context, state) {
        var model = SocialCubit
            .get(context)
            .posts;
        return ConditionalBuilder(
          condition:model!.length > 0  && SocialCubit.get(context).model != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                      elevation: 5,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const Image(
                              image: NetworkImage(
                                  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg')),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Communicate with friends',
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                 ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index)=> itemsPost(context , SocialCubit.get(context).posts![index] , index),
                      separatorBuilder: (context, state)=>const SizedBox(height: 3,),
                      itemCount: SocialCubit.get(context).posts!.length,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget itemsPost(context , posts , index) =>  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Card(
                elevation: 5.0,
                child: Row(
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=1060&t=st=1663879804~exp=1663880404~hmac=d98690cc2f45cc17c775563e97ddd9f9fee968683fad66f83fb8efc691aa8a14'
                      ),
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
                                '${posts.name}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                  height: 1,
                                ),
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 16.0,
                                color: defaultColor,
                              ),
                            ],
                          ),
                          Text(
                            '${posts.dateTime}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              height: 1.6,
                            ),
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
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: SizedBox(
                height: 1,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
               bottom: 5
              ),
              child: Text(
                '${posts.text}',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(height: 1.3, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    height: 16,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_Development',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.blue
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 16,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.blue
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 16,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_Development',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.blue
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 16,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_Development',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.blue
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(posts.postImage != "")
            Padding(
              padding: const EdgeInsets.only(
                top: 7 ,
              ),
              child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      image:  DecorationImage(
                        image: NetworkImage(
                            '${posts.postImage}'
                        ),
                        fit: BoxFit.cover,
                      ))
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          Text(
                            "${SocialCubit.get(context).mpLikes[SocialCubit.get(context).posUid![index]]}",
                            //"${SocialCubit.get(context).numberPostLike![index]}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context).likePosts(SocialCubit.get(context).posUid![index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            "${SocialCubit.get(context).mpComments[SocialCubit.get(context).posUid![index]]}",
                            //"${SocialCubit.get(context).numberPostComment![index]}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                          const SizedBox(width: 2,),
                          Text(
                            "comments",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context).commentPost(SocialCubit.get(context).posUid![index]) ;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model!.image}'),
                      radius: 18,
                    ),
                    const SizedBox(width: 7,),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'write comments ...',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: const Icon(
                        IconBroken.Heart,
                        size: 18,
                        color: Colors.red,
                      ),
                      onTap: () {
                        SocialCubit.get(context).likePosts(SocialCubit.get(context).posUid![index]);
                      },
                    ),
                    const SizedBox(width: 3,),
                    const Text(
                      'Like',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

