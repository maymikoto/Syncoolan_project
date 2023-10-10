// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Post {
  String postId;          // Unique Identifier
  String authorId;        // User ID
  String communityId;     // Community ID
  String content;         // Post Content
  DateTime postDate;      // Post Date
  List<String> likes;     // List of User IDs who liked the post// List of Comment IDs
  String linkedEventId;   // Identifier or reference to the related schedule event (optional)
  String imageUrls; // List of URLs to images attached to the post (optional)       // URL link associated with the post (optional)
  Post({
    required this.postId,
    required this.authorId,
    required this.communityId,
    required this.content,
    required this.postDate,
    required this.likes,
    required this.linkedEventId,
    required this.imageUrls,
  });

  Post copyWith({
    String? postId,
    String? authorId,
    String? communityId,
    String? content,
    DateTime? postDate,
    List<String>? likes,
    String? linkedEventId,
    String? imageUrls,
  }) {
    return Post(
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      communityId: communityId ?? this.communityId,
      content: content ?? this.content,
      postDate: postDate ?? this.postDate,
      likes: likes ?? this.likes,
      linkedEventId: linkedEventId ?? this.linkedEventId,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'authorId': authorId,
      'communityId': communityId,
      'content': content,
      'postDate': postDate.millisecondsSinceEpoch,
      'likes': likes,
      'linkedEventId': linkedEventId,
      'imageUrls': imageUrls,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      authorId: map['authorId'] ?? '',
      communityId: map['communityId'] ?? '',
      content: map['content'] ?? '',
      postDate: DateTime.fromMillisecondsSinceEpoch(map['postDate']),
      likes: List<String>.from((map['likes'] )),
      linkedEventId: map['linkedEventId'] ?? '',
      imageUrls: map['imageUrls'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(postId: $postId, authorId: $authorId, communityId: $communityId, content: $content, postDate: $postDate, likes: $likes, linkedEventId: $linkedEventId, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.postId == postId &&
      other.authorId == authorId &&
      other.communityId == communityId &&
      other.content == content &&
      other.postDate == postDate &&
      listEquals(other.likes, likes) &&
      other.linkedEventId == linkedEventId &&
      other.imageUrls == imageUrls;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
      authorId.hashCode ^
      communityId.hashCode ^
      content.hashCode ^
      postDate.hashCode ^
      likes.hashCode ^
      linkedEventId.hashCode ^
      imageUrls.hashCode;
  }
}
