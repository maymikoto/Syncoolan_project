// ignore_for_file: public_member_api_docs, sort_constructors_first


class UserModel {
  final String name;
  final String email;
  final String profilePic;
  final String uid; 
  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.profilePic == profilePic &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      profilePic.hashCode ^
      uid.hashCode;
  }
}
