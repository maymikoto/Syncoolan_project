// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EventModel {
  String eventId;           // Unique Identifier for the event
  String eventName;         // Name or title of the event
  String eventDescription;  // Description of the event
  DateTime eventDate;      // Date of the event
  DateTime eventTime;     // Time of the event
  String eventColor;        // Color associated with the event
  String communityId;      // ID of the community to which the event belongs
  String creatorUserId; 


  EventModel({
    String? eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    required this.eventColor,
    required this.communityId,
    required this.creatorUserId,
  }): eventId = eventId ?? const Uuid().v4(); 

  EventModel copyWith({
    String? eventId,
    String? eventName,
    String? eventDescription,
    DateTime? eventDate,
    DateTime? eventTime,
    String? eventColor,
    String? communityId,
    String? creatorUserId,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      eventColor: eventColor ?? this.eventColor,
      communityId: communityId ?? this.communityId,
      creatorUserId: creatorUserId ?? this.creatorUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'eventTime': eventTime.millisecondsSinceEpoch,
      'eventColor': eventColor,
      'communityId': communityId,
      'creatorUserId': creatorUserId,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventDate: DateTime.fromMillisecondsSinceEpoch(map['eventDate'] ),
      eventTime: DateTime.fromMillisecondsSinceEpoch(map['eventTime'] ),
      eventColor: map['eventColor'] ?? '',
      communityId: map['communityId'] ?? '',
      creatorUserId: map['creatorUserId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, eventName: $eventName, eventDescription: $eventDescription, eventDate: $eventDate, eventTime: $eventTime, eventColor: $eventColor, communityId: $communityId, creatorUserId: $creatorUserId)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventId == eventId &&
      other.eventName == eventName &&
      other.eventDescription == eventDescription &&
      other.eventDate == eventDate &&
      other.eventTime == eventTime &&
      other.eventColor == eventColor &&
      other.communityId == communityId &&
      other.creatorUserId == creatorUserId;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
      eventName.hashCode ^
      eventDescription.hashCode ^
      eventDate.hashCode ^
      eventTime.hashCode ^
      eventColor.hashCode ^
      communityId.hashCode ^
      creatorUserId.hashCode;
  }
}
