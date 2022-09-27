import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/modules/edit_profile/edit_profile_screen.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, MainSocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.0,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage('${userModel!.cover}'),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                      CircleAvatar(
                        radius: 52,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${userModel.image}'),
                          radius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${userModel.name}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${userModel.bio}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('100'),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Posts',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('265'),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Photos',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('10k'),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Followers',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('10'),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                child: const Text('Add Photo'),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            OutlinedButton(
                              child: const Icon(
                                IconBroken.Edit,
                                size: 17,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            child:const Text(
                              'Subscribe',
                            ),
                            onPressed: () {
                              FirebaseMessaging.instance.subscribeToTopic('good');
                            },
                          ),
                          SizedBox(width: 20,),
                          OutlinedButton(
                            child:const Text(
                              'un Subscribe',
                            ),
                            onPressed: () {
                              FirebaseMessaging.instance.unsubscribeFromTopic('good');
                            }
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
