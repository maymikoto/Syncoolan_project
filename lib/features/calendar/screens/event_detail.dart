import 'package:flutter/material.dart';
import 'package:syncoplan_project/core/models/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Event Name: ${event.eventName}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Event Date: ${event.eventDate}',
              style: TextStyle(fontSize: 20),
            ),
            // Add more event details here
          ],
        ),
      ),
    );
  }
}
