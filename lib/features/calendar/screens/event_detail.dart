import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';

class EventDetailPage extends ConsumerWidget {
  final EventModel event;
  EventDetailPage({required this.event});

 void deleteEvent(WidgetRef ref, BuildContext context) async {
    ref.read(eventControllerProvider.notifier).deleteEvent(event, context);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    DateTime eventDate = event.eventDate;
    String formattedDate = DateFormat('dd MMM yyyy').format(eventDate);
    TimeOfDay startTime = event.startTime;
    String formattedStartTime = "${startTime.hour}:${startTime.minute}";
    TimeOfDay endTime = event.endTime;
    String formattedEndTime = "${endTime.hour}:${endTime.minute}";
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Align(
            alignment: Alignment.topLeft, // Align to the top-left
            child: SingleChildScrollView(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: event.eventColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight, // Align to the top-right
                        child: Row(
                          children: [
                           const Text(
                        'Event Detail',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                      ),Spacer(),
                              event.creatorUserId == user.uid ?  
                            IconButton(
                              onPressed: () { deleteEvent(ref, context);},
                              icon: Icon(EvaIcons.trash2Outline, color: Colors.white), 
                            )
                            : SizedBox(width: 1,)  
                          ],
                        ),
                      ),
                      Text(
                        'Event Name: ${event.eventName}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      if (event.eventDescription != '')
                        Text(
                          'Event Description: ${event.eventDescription}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      Text(
                        'Event Date: $formattedDate',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      Text(
                        'Start time: $formattedStartTime',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      Text(
                        'End time: $formattedEndTime',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      Text(
                        'Created by: ${event.creatorUsername}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      Text(
                        'Created in community: ${event.communityName}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
