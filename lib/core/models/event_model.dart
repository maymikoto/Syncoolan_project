import 'package:flutter/material.dart';

class EventModel {
  String eventId;
  String eventName;
  String eventDescription;
  DateTime eventDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  Color eventColor;
  String communityId;
  String communityName;
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

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'] as String? ?? '',
      eventName: map['eventName'] as String? ?? '',
      eventDescription: map['eventDescription'] as String? ?? '',
      eventDate: map['eventDate'] == null
          ? DateTime.now() // Provide a default value if 'eventDate' is null
          : DateTime.fromMillisecondsSinceEpoch(map['eventDate'] as int),
      startTime: map['startTimeHour'] == null || map['startTimeMinute'] == null
          ? TimeOfDay(hour: 0, minute: 0) // Provide default values if 'startTime' is null
          : TimeOfDay(
              hour: map['startTimeHour'] as int,
              minute: map['startTimeMinute'] as int,
            ),
      endTime: map['endTimeHour'] == null || map['endTimeMinute'] == null
          ? TimeOfDay(hour: 0, minute: 0) // Provide default values if 'endTime' is null
          : TimeOfDay(
              hour: map['endTimeHour'] as int,
              minute: map['endTimeMinute'] as int,
            ),
      eventColor: map['eventColor'] == null
          ? Colors.transparent // Provide a default color if 'eventColor' is null
          : Color(map['eventColor'] as int),
      communityId: map['communityId'] as String? ?? '',
      communityName: map['communityName'] as String? ?? '',
      creatorUserId: map['creatorUserId'] as String? ?? '',
      creatorUsername: map['creatorUsername'] as String? ?? '',
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

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, eventName: $eventName, eventDescription: $eventDescription, eventDate: $eventDate, startTime: $startTime, endTime: $endTime, eventColor: $eventColor, communityId: $communityId, communityName: $communityName, creatorUserId: $creatorUserId, creatorUsername: $creatorUsername)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;

    return other.eventId == eventId &&
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
