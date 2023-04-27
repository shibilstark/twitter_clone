// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String coverPic;
  final String profilePic;
  final List<String> followers;
  final List<String> following;
  final bool isTwitterVerfied;
  final List<String> tweets;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.coverPic,
    required this.profilePic,
    required this.followers,
    required this.following,
    required this.isTwitterVerfied,
    required this.tweets,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    String? coverPic,
    String? profilePic,
    List<String>? followers,
    List<String>? following,
    bool? isTwitterVerfied,
    List<String>? tweets,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      coverPic: coverPic ?? this.coverPic,
      profilePic: profilePic ?? this.profilePic,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isTwitterVerfied: isTwitterVerfied ?? this.isTwitterVerfied,
      tweets: tweets ?? this.tweets,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'bio': bio,
      'coverPic': coverPic,
      'profilePic': profilePic,
      'followers': followers,
      'following': following,
      'isTwitterVerfied': isTwitterVerfied,
      'tweets': tweets,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['\$id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      coverPic: map['coverPic'] as String,
      profilePic: map['profilePic'] as String,
      followers:
          (map['followers'] as List<dynamic>).map((e) => e.toString()).toList(),
      following:
          (map['following'] as List<dynamic>).map((e) => e.toString()).toList(),
      isTwitterVerfied: map['isTwitterVerfied'] as bool,
      tweets:
          (map['tweets'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
}
