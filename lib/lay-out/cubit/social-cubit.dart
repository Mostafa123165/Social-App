import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/lay-out/cubit/social-state.dart';
import 'package:firebase1/model/message_model.dart';
import 'package:firebase1/model/post-model.dart';
import 'package:firebase1/model/user-model.dart';
import 'package:firebase1/modules/chat/chat_screen.dart';
import 'package:firebase1/modules/home/home-screen.dart';
import 'package:firebase1/modules/post/post_screen.dart';
import 'package:firebase1/modules/settings/settings_screen.dart';
import 'package:firebase1/modules/users/user_screen.dart';
import 'package:firebase1/shared/constant/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<MainSocialState> {
  SocialCubit() : super(InitialSocialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    const HomeScreen(),
    const ChatsScreen(),
    const PostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> title = [
    "Home",
    "Chats",
    "Post",
    "Users",
    "Settings",
  ];

  UserModel? model;

  void getDataUser() {
    emit(GetDataUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data() ?? {});
      print("--------------------------------") ;
      print(model!.uId) ;
      print(model!.name) ;
      emit(GetDataUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataUserErrorState());
    });
  }

  int currentIndex = 0;

  void changeBottomNav(int index, context) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PostScreen()),
      );
    } else {
      currentIndex = index;
      if (index == 1) {
        getAllUser();
      }
      emit(ChangeBottomNavState());
    }
  }

  File? profileImage;

  var picker = ImagePicker();

  Future getImageProfile() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) => {
          if (value != null)
            {
              profileImage = File(value.path),
              emit(GetProfileImageSuccessState()),
            }
          else
            {
              print("NO image selected."),
              emit(GetProfileImageErrorState()),
            },
        });
  }

  File? coverImage;

  Future getImageCover() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) => {
          if (value != null)
            {
              coverImage = File(value.path),
              emit(GetProfileImageSuccessState()),
            }
          else
            {
              print("NO image selected."),
              emit(GetProfileImageErrorState()),
            },
        });
  }

  String newImageProfile = '';

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, profile: value);
        newImageProfile = value;
        //emit(UploadImageProfileSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadImageProfileErrorState());
      });
    });
  }

  String newImageCover = '';

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserCoverLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        newImageCover = value;
        emit(UploadImageCoverSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadImageCoverErrorState());
      });
    });
  }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? profile}) {
    UserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: profile ?? model!.image,
      cover: cover ?? model!.cover,
      uId: model!.uId,
      email: model!.email,
      verify: model!.verify,
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set({
      "name": name,
      "phone": phone,
      "bio": bio,
      "cover": cover ?? model!.cover,
      "image": profile ?? model!.image,
      "uId": model!.uId,
      "email": model!.email,
      "verify": model!.verify,
    }).then((value) {
      getDataUser();
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState());
    });
  }

  File? postImage;

  Future getPostImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) => {
          if (value != null)
            {
              postImage = File(value.path),
              emit(GetPostImagePostSuccessState()),
            }
          else
            {
              print("NO image selected."),
              emit(GetPostImagePostErrorState()),
            },
        });
  }

  void uploadPostImage({
    // found image Post
    required String text,
    required String dateTime,
    context,
  }) {
    emit(GetPostImagePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
            text: text, dateTime: dateTime, postImage: value, context: context);
        //  emit(UploadImagePostSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadImagePostErrorState());
      });
    });
  }

  void createPost( // no fount image post
      {
    required String text,
    required String dateTime,
    String? postImage,
    context,
  }) {
    emit(GetPostImagePostLoadingState());
    PostModel post = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
      removePostImage();
      Navigator.pop(context);
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel>? posts = [];

  List<int>? numberPostLike = [];
  List<int>? numberPostComment = [];

  List<String>? posUid = [];

  var mpLikes = new Map();
  var mpComments = new Map();

  void getPosts() {
    emit(GetPostLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          numberPostLike!.add(value.docs.length);
          mpLikes[element.id] = value.docs.length;
        });

        element.reference.collection('comments').get().then((value) {
          numberPostComment!.add(value.docs.length);
          posUid!.add(element.id);
          posts!.add(PostModel.fromJson(element.data()));
          mpComments[element.id] = value.docs.length;
          emit(GetPostSuccessState());
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetPostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessState());
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      "like": true,
    }).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState());
      print(error.toString());
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({
      "comment": true,
    }).then((value) {
      emit(PostCommentSuccessState());
    }).catchError((error) {
      emit(PostCommentErrorState());
      print(error.toString());
    });
  }

  List<UserModel>? users = []; // friends

  void getAllUser() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      if (users!.length == 0)
        value.docs.forEach((element) {
          if (model!.uId != element.data()['uId'])
            users!.add(UserModel.fromJson(element.data()));
        });
    }).then((value) {
      print(model!.uId);
      users!.forEach((element) {
        print(element.uId) ;
      });
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUserSuccessState());
    });
  }

  void sendMessage({
    required String? text,
    required String? dateTime,
    required String? receiverId,
  }) {
    MessageModel message = MessageModel(
      text: text,
      dateTime: DateTime.now().toString(),
      receiverId: receiverId,
      senderId: model!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      print(error.toString());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('message')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      print(error.toString());
    });
  }

  List<MessageModel?> message = [];

  void getAllMessage({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
        message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(GetAllMessageSuccessState());
    });
  }

}
