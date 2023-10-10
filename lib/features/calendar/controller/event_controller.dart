import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/either.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/repository/calendar_repository.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/community/repository/commu_repository.dart';
import 'package:uuid/uuid.dart';


final userEventsProvider = StreamProvider((ref) {
  final eventController = ref.watch(eventControllerProvider.notifier);
  return eventController.getUserEvents();
});

final eventControllerProvider = StateNotifierProvider<EventController, bool>((ref) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);

  return EventController(
    eventRepository: eventRepository,
    ref: ref,
    storageRepository: storageRepository,
  );
});

final getEventByIdProvider = StreamProvider.family((ref, String id) {
  return ref.watch(eventControllerProvider.notifier).getEventById(id);
});


class EventController extends StateNotifier<bool> {
  final EventRepository _eventRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  EventController({
    required EventRepository eventRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _eventRepository = eventRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);
        
  

  void createEvent(
   String name,
   String description,
   String cid,
   String cname,
   DateTime eventDate,
   TimeOfDay startTime,
   TimeOfDay endTime,
   Color eventcolor,

  BuildContext context) 
    async {
    state = true;
    final user = _ref.read(userProvider)!;
    String eventId = const Uuid().v1();

    EventModel event = EventModel(
      eventId:eventId ,
      eventName: name,
      eventDescription: description,
      eventDate: eventDate,
      startTime: startTime,
      endTime: endTime,
      eventColor: eventcolor, // Set your initial color
      communityId:cid,
      communityName: cname,
      creatorUserId: user.uid,
      creatorUsername:user.name, // Set creator's username
    );

    final res = await _eventRepository.createEvent(event);
    state = false;

    res.fold((l) => showErrorSnackBar(context, l.message), (r) {
      showSuccessSnackBar(context, 'Event created successfully!');
      Navigator.pop(context); // Use Navigator.pop to navigate back
    });
  }

  Stream<EventModel> getUserEvents() {
    final id = _ref.read(userProvider)!.uid;
    return _eventRepository.getEventById(id);
  }

  Stream<EventModel> getEventById(String id) {
    return _eventRepository.getEventById(id);
  }

  Future<Either<Failure, List<EventModel>>> getCommunityEvents(String communityId) {
    return _eventRepository.getCommunityEvents(communityId);
  }

  Stream<List<EventModel>> getCommunityEventsAsStream(String communityId) async* {
  final result = await getCommunityEvents(communityId);
  yield* result.fold(
    (failure) => Stream<List<EventModel>>.error(failure), // Error case
    (events) => Stream<List<EventModel>>.value(events),   // Success case
  );
}

}
