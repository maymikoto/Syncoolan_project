import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class CalendarScreen extends ConsumerWidget {
  final String id;
  const CalendarScreen({required this.id, Key? key}) : super(key: key);

  void navigateToAddEvent(BuildContext context) {
    Routemaster.of(context).push('/add-event/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    
    // Use the event controller to fetch community events
    final events = ref.watch(eventControllerProvider.notifier).getCommunityEventsAsStream(id);

    // Create an instance of MyCalendarDataSource using the events stream
    final dataSource = MyCalendarDataSource(events);

    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          dataSource: dataSource, // Use the new data source here
        ),
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

class MyCalendarDataSource extends CalendarDataSource {
  final Stream<List<EventModel>> events; // Change the events type to Stream

  MyCalendarDataSource(this.events);
}
