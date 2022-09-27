import 'package:firebase1/lay-out/cubit/social-cubit.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/shared/componets/componets.dart';
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'  ;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameControler = TextEditingController();
    var bioControler = TextEditingController();
    var phoneControler = TextEditingController();
    return BlocConsumer<SocialCubit, MainSocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).model;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameControler.text = userModel!.name! ;
          bioControler.text = userModel.bio! ;
          phoneControler.text = userModel.phone! ;
          return Scaffold(
            appBar: defaultAppar(
              context: context,
              title: 'Edit Profile',
              action: [
                TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(name: nameControler.text, phone: phoneControler.text, bio: bioControler.text) ;
                  },
                  child: Text(
                    'UPDATE',
                  ),
                ),
              ],
              onPressed: (){
                Navigator.pop(context);
              }
            ),
            body: SingleChildScrollView(
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
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                        image: DecorationImage(
                                          image: coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage) as ImageProvider ,
                                          fit: BoxFit.cover,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 16,
                                      child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context).getImageCover() ;
                                        },
                                        icon: Icon(
                                          IconBroken.Camera,
                                          size: 16,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 52,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null ?  NetworkImage('${userModel.image}') : FileImage(profileImage) as ImageProvider,
                                  radius: 50,
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 16,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getImageProfile();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage != null )
                        Expanded(

                          child: Column(
                            children: [
                                defaultMaterialButton(
                                  text: "Upload Profile",
                                  onPressed: (){
                                    SocialCubit.get(context).uploadProfileImage(name: nameControler.text , phone: phoneControler.text , bio: bioControler.text);
                                  },
                              ),
                              if(state is UpdateUserImageLoadingState)
                                SizedBox(height: 5,),
                              if(state is UpdateUserImageLoadingState)
                                const LinearProgressIndicator(),
                            ],

                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        if(SocialCubit.get(context).coverImage != null )
                        Expanded(
                          child: Column(
                            children: [
                               defaultMaterialButton(
                                  text: "Upload Cover",
                                  onPressed: (){
                                    SocialCubit.get(context).uploadCoverImage(name: nameControler.text, phone: phoneControler.text, bio: bioControler.text);
                                  }
                              ),
                              if(state is UpdateUserCoverLoadingState)
                                SizedBox(height: 5,),
                              if(state is UpdateUserCoverLoadingState)
                                const LinearProgressIndicator(),
                            ],

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    defaultTextFormField(
                        controller: nameControler,
                        prefixIcon: Icon(IconBroken.User),
                        submitted: (value){},
                        validator: (value){
                          if(value.toString().isNotEmpty){
                            return "Name must not be empty ";
                          }
                          return null ;
                        },
                        lapel: "Name"
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        controller: bioControler,
                        prefixIcon: Icon(IconBroken.Info_Circle),
                        submitted: (value){},
                        validator: (value){
                          if(value.toString().isNotEmpty){
                            return "Bio must not be empty ";
                          }
                          return null ;
                        },
                        lapel: "Bio"
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        controller: phoneControler,
                        prefixIcon: Icon(IconBroken.Graph),
                        submitted: (value){},
                        validator: (value){
                          if(value.toString().isNotEmpty){
                            return "Bio must not be empty ";
                          }
                          return null ;
                        },
                        lapel: "Phone"
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
