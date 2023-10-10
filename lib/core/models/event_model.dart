// import statements for necessary packages

import 'package:flutter/material.dart';

class EventModel {
  String eventId;           // Unique Identifier for the event
  String eventName;
  String eventDescription;
  DateTime eventDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  Color eventColor;        // Color associated with the event
  String communityId;     
  String communityName;     // ID of the community to which the event belongs
  String creatorUserId;
  String creatorUsername; 

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.eventColor,
    required this.communityId,
    required this.communityName,
    required this.creatorUserId,
    required this.creatorUsername,
  });

  EventModel copyWith({
    String? eventId,
    String? eventName,
    String? eventDescription,
    DateTime? eventDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Color? eventColor,
    String? communityId,
    String? communityName,
    String? creatorUserId,
    String? creatorUsername,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      eventColor: eventColor ?? this.eventColor,
      communityId: communityId ?? this.communityId,
      communityName: communityName ?? this.communityName,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      creatorUsername: creatorUsername ?? this.creatorUsername,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'startTimeHour': startTime.hour,
      'startTimeMinute': startTime.minute,
      'endTimeHour': endTime.hour,
      'endTimeMinute': endTime.minute,
      'eventColor': eventColor.value,
      'communityId': communityId,
      'communityName': communityName,
      'creatorUserId': creatorUserId,
      'creatorUsername': creatorUsername,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventDate: DateTime.fromMillisecondsSinceEpoch(map['eventDate'] as int),
      startTime: TimeOfDay(
        hour: map['startTimeHour'] as int,
        minute: map['startTimeMinute'] as int,
      ),
      endTime: TimeOfDay(
        hour: map['endTimeHour'] as int,
        minute: map['endTimeMinute'] as int,
      ),
      eventColor: Color(map['eventColor'] as int),
      communityId: map['communityId'] ?? '',
      communityName: map['communityName'] ?? '',
      creatorUserId: map['creatorUserId'] ?? '',
      creatorUsername: map['creatorUsername'] ?? '',
    );
  }


  @override
  String toString() {
    return 'EventModel(eventId: $eventId, eventName: $eventName, eventDescription: $eventDescription, eventDate: $eventDate, startTime: $startTime, endTime: $endTime, eventColor: $eventColor, communityId: $communityId, communityName: $communityName, creatorUserId: $creatorUserId, creatorUsername: $creatorUsername)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventId == eventId &&
      other.eventName == eventName &&
      other.eventDescription == eventDescription &&
      other.eventDate == eventDate &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.eventColor == eventColor &&
      other.communityId == communityId &&
      other.communityName == communityName &&
      other.creatorUserId == creatorUserId &&
      other.creatorUsername == creatorUsername;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
      eventName.hashCode ^
      eventDescription.hashCode ^
      eventDate.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      eventColor.hashCode ^
      communityId.hashCode ^
      communityName.hashCode ^
      creatorUserId.hashCode ^
      creatorUsername.hashCode;
  }
}
