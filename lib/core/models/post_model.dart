// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Post {
  String postId;          // Unique Identifier
  String authorId;        // User ID
  String communityId;     // Community ID
  String content;         // Post Content
  DateTime postDate;      // Post Date
  List<String> likes;     // List of User IDs who liked the post
  List<String> comments;// List of Comment IDs
  String linkedEventId;   // Identifier or reference to the related schedule event (optional)
  List<String> imageUrls; // List of URLs to images attached to the post (optional)       // URL link associated with the post (optional)
  
  Post({
    String? postId,
    required this.authorId,
    required this.communityId,
    required this.content,
    required this.postDate,
    required this.likes,
    required this.comments,
    required this.linkedEventId,
    required this.imageUrls,
  }): postId = postId ?? const Uuid().v4(); 

  Post copyWith({
    String? postId,
    String? authorId,
    String? communityId,
    String? content,
    DateTime? postDate,
    List<String>? likes,
    List<String>? comments,
    String? linkedEventId,
    List<String>? imageUrls,
  }) {
    return Post(
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      communityId: communityId ?? this.communityId,
      content: content ?? this.content,
      postDate: postDate ?? this.postDate,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
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
      'comments': comments,
      'linkedEventId': linkedEventId,
      'imageUrls': imageUrls,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '' ,
      authorId: map['authorId'] ?? '',
      communityId: map['communityId'] ?? '' ,
      content: map['content'] ?? '',
      postDate: DateTime.fromMillisecondsSinceEpoch(map['postDate']),
      likes: List<String>.from(map['likes']),
      comments: List<String>.from(map['comments'] ),
      linkedEventId: map['linkedEventId'] ?? '',
      imageUrls: List<String>.from((map['imageUrls'])),
    );
  }

  @override
  String toString() {
    return 'PostModel(postId: $postId, authorId: $authorId, communityId: $communityId, content: $content, postDate: $postDate, likes: $likes, comments: $comments, linkedEventId: $linkedEventId, imageUrls: $imageUrls)';
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
      listEquals(other.comments, comments) &&
      other.linkedEventId == linkedEventId &&
      listEquals(other.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
      authorId.hashCode ^
      communityId.hashCode ^
      content.hashCode ^
      postDate.hashCode ^
      likes.hashCode ^
      comments.hashCode ^
      linkedEventId.hashCode ^
      imageUrls.hashCode;
  }
}
