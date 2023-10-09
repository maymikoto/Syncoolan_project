// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class Comment {
  final String commentId; // Unique Identifier
  final String authorId;  // User ID
  final String postId;    // Post ID
  final String commentContent; // Comment Content as a string
  final DateTime commentDate; // Comment Date and Time
 
  Comment({
    String? commentId,
    required this.authorId,
    required this.postId,
    required this.commentContent,
    required this.commentDate,
  }): commentId = commentId ?? const Uuid().v4(); 

  Comment copyWith({
    String? commentId,
    String? authorId,
    String? postId,
    String? commentContent,
    DateTime? commentDate,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      authorId: authorId ?? this.authorId,
      postId: postId ?? this.postId,
      commentContent: commentContent ?? this.commentContent,
      commentDate: commentDate ?? this.commentDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'authorId': authorId,
      'postId': postId,
      'commentContent': commentContent,
      'commentDate': commentDate.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId'] ?? '',
      authorId: map['authorId'] ?? '',
      postId: map['postId'] ?? '',
      commentContent: map['commentContent'] ?? '',
      commentDate: DateTime.fromMillisecondsSinceEpoch(map['commentDate']),
    );
  }

  @override
  String toString() {
    return 'Comment(commentId: $commentId, authorId: $authorId, postId: $postId, commentContent: $commentContent, commentDate: $commentDate)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.commentId == commentId &&
      other.authorId == authorId &&
      other.postId == postId &&
      other.commentContent == commentContent &&
      other.commentDate == commentDate;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
      authorId.hashCode ^
      postId.hashCode ^
      commentContent.hashCode ^
      commentDate.hashCode;
  }
}
