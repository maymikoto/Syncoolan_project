import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';
import 'package:syncoplan_project/features/calendar/screens/event_detail.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';

class CaledndarScreen extends ConsumerWidget {
  const CaledndarScreen({super.key});

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final uid = user.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchCommunityDelegate(ref),
              );
            },
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic),
                ),
                onPressed: () => displayEndDrawer(context),
              );
            },
          )
        ],
      ),
      endDrawer: const ProfileDrawer(),
      body: SafeArea(
        child: CalendarWithEvents(uid: uid),
      ),
    );
  }
}

class CalendarWithEvents extends ConsumerWidget {
  final String uid;
  CalendarWithEvents({required this.uid, super.key});

  void navigateToEventDetail(BuildContext context, EventModel event) {
    // Navigate to the event detail page and pass the event data
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailPage(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch events for the community with the given id
   // final AsyncValue<List<EventModel>> events = ref.watch(getCommunityEventProvider(commmities.));

    return ref.watch(userCommunitiesProvider).when(
      data: (communities) {
        final AsyncValue<List<EventModel>> events = ref.watch(userEventProvider(communities));

        return events.when(
          data: (eventList) {
            print("Events: $eventList"); 
            final calendarEvents = eventList.map((event) {
              return Appointment(
                startTime: DateTime(event.eventDate.year, event.eventDate.month, event.eventDate.day, event.startTime.hour, event.startTime.minute),
                endTime: DateTime(event.eventDate.year, event.eventDate.month, event.eventDate.day, event.endTime.hour, event.endTime.minute),
                subject: event.eventName,
                color: event.eventColor,
              );
            }).toList();

            return SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(calendarEvents),
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
                  final DateTime? selectedDate = calendarTapDetails.date;

                  if (selectedDate != null) {
                    final selectedEvents = eventList.where((event) =>
                      event.eventDate.year == selectedDate.year &&
                      event.eventDate.month == selectedDate.month &&
                      event.eventDate.day == selectedDate.day,
                    ).toList();

                    if (selectedEvents.isNotEmpty) {
                      navigateToEventDetail(context, selectedEvents.first);
                    }
                  }
                }
              },
            );
          },
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
        );
      },
      loading: () => const Loader(),
      error: (error, stackTrace) => ErrorText(error: error.toString()),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
