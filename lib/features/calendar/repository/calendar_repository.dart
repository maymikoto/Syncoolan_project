/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncoplan_project/core/constants/firebase_constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/providers/firebase_providers.dart';
import 'package:syncoplan_project/core/type_defs.dart';

final eventRepositoryProvider = Provider((ref) {
  return EventRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class EventRepository {
  final FirebaseFirestore _firestore;
  EventRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _events => _firestore.collection(FirebaseConstants.eventsCollection);

  FutureVoid createEvent(EventModel event) async {
    try {
      return right(_events.doc(event.eventId).set(event.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<EventModel>> fetchUserEvents() {
    return _events
        .orderBy('eventDate')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => EventModel.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  FutureVoid deleteEvent(EventModel event) async {
    try {
      return right(_events.doc(event.eventId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<EventModel> getEventById(String eventId) {
    return _events.doc(eventId).snapshots().map((event) => EventModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<Either> updateEvent(EventModel event) async {
    try {
      return right(_events.doc(event.eventId).update(event.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<EventModel>>> getCommunityEvents(String communityId) async {
  try {
    final querySnapshot = await _events
        .where('communityId', isEqualTo: communityId)
        .get();

    final events = querySnapshot.docs.map((doc) {
      final eventData = doc.data() as Map<String, dynamic>;
      return EventModel.fromMap(eventData);
    }).toList();

    return right(events);
  } on FirebaseException catch (e) {
    return left(Failure(e.message!));
  } catch (e) {
    return left(Failure(e.toString()));
  }
}

 Future<Either<Failure, List<EventModel>>> getCommunityCalendarEvents(String communityId) async {
    try {
      final querySnapshot = await _firestore
          .collection('communities')
          .doc(communityId)
          .collection('events')
          .get();

      final events = querySnapshot.docs.map((doc) {
        final eventData = doc.data() as Map<String, dynamic>;
        return EventModel.fromMap(eventData);
      }).toList();

      return right(events);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
*/

// event_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncoplan_project/core/constants/firebase_constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/providers/firebase_providers.dart';
import 'package:syncoplan_project/core/type_defs.dart';


//
final eventRepositoryProvider = Provider((ref) {
  return EventRepository(firestore: ref.watch(firestoreProvider));
});


class EventRepository {
  final FirebaseFirestore _firestore;
  EventRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _events => _firestore.collection(FirebaseConstants.eventsCollection); 
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);


 FutureVoid addEvent(EventModel event) async {
    try {
      return right(_events.doc(event.eventId).set(event.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

 Stream<List<EventModel>> fetchUserEvents(List<EventModel> communities) {
    return _events
        .where('communityId', whereIn: communities.map((e) => e.communityId).toList())
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => EventModel.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }


  FutureVoid deleteEvent(EventModel event) async {
    try {
      return right(_events.doc(event.eventId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }


  Stream<List<EventModel>> getEventsForUserGroups(String userId) {
    return _firestore.collection('events').where('members', arrayContains: userId).snapshots().map((event) {
      List<EventModel> events = [];
      for (var doc in event.docs) {
        events.add(EventModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return events;
    });
  }

  Stream<List<EventModel>> getEventsInCommunity(String communityId) {
    return _firestore.collection('events').doc(communityId).collection('events').snapshots().map((event) {
      List<EventModel> events = [];
      for (var doc in event.docs) {
        events.add(EventModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return events;
    });
  }

Stream<EventModel> getEventById(String eventId) {
  return _events.doc(eventId).snapshots().map((event) => EventModel.fromMap(event.data() as Map<String, dynamic>));
}

  createEvent(EventModel event) {}


}

