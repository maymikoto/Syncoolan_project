import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';

class CalendarScreen extends ConsumerWidget {
  final String id;
  CalendarScreen({required this.id, super.key});

  void navigateToAddEvent(BuildContext context) {
    Routemaster.of(context).push('/add-event/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SafeArea(
        child: CalendarWithEvents(id: id),
      ),
      floatingActionButton: ref.watch(getCommunityByIdProvider(id)).when(
        data: (community) => community.members.contains(user.uid)
            ? FloatingActionButton(
                onPressed: () => navigateToAddEvent(context),
                backgroundColor: Colors.green,
                child: const Icon(Icons.add_box),
              )
            : null,
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader(),
      ),
    );
  }
}

class CalendarWithEvents extends ConsumerWidget {
  final String id;
  CalendarWithEvents({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch events for the community with the given id
    final AsyncValue<List<EventModel>> events = ref.watch(getCommunityEventProvider(id));

    return events.when(
      data: (eventList) {
        print("Events: $eventList"); // Add this debug print statement

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
