class UserModel {
  String? email;
  String? name;
  String? phone;
  String? uId;
  bool? verify;
  String? image;
  String? cover;
  String? bio;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.verify,
    this.image,
    this.cover,
    this.bio
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    uId = json["uId"];
    verify = json["verify"];
    image = json["image"];
    cover = json["cover"];
    bio = json["bio"];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'verify': verify,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
