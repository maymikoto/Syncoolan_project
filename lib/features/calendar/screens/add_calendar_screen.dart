import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/widgets/custom_datepicker.dart';
import 'package:syncoplan_project/core/widgets/textfield.dart';
import 'package:intl/intl.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class AddCalendarScreen extends ConsumerStatefulWidget {
  final String id;
  const AddCalendarScreen({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCalendarScreenState();
}

final eventNameController = TextEditingController();
final eventDescriptionController = TextEditingController();
final eventDateController = TextEditingController();
final eventStartTimeController = TextEditingController();
final eventEndTimeController = TextEditingController();
Color _selectedColor = Colors.blue; // Set an initial color

DateTime? firstDate;
DateTime? lastDate;

class _AddCalendarScreenState extends ConsumerState<AddCalendarScreen> {
  DateTime? _selectedDate;
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedStartTime = TimeOfDay.now();
    _selectedEndTime = TimeOfDay.now();
  }

  Future<void> _pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
        eventDateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

Future<void> _pickTime(BuildContext context, TextEditingController controller) async {
  final selectedTime = await showTimePicker(
    context: context,
    initialTime: controller == eventStartTimeController
        ? _selectedStartTime
        : _selectedEndTime,
  );

  if (selectedTime != null) {
    setState(() {
      if (controller == eventStartTimeController) {
        _selectedStartTime = selectedTime;
      } else {
        _selectedEndTime = selectedTime;
      }
      final selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      controller.text = DateFormat.jm().format(selectedDateTime);
    });
  }
}


  Future<void> _pickEndTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime!,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedEndTime = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
final communityData = ref.watch(getCommunityByIdProvider(widget.id));
String communityName = '';

communityData.whenData((community) {
  // Use community.name inside the callback
  communityName = community.name;
});


    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event'),
        actions: [
IconButton(
  onPressed: () async {
    final name = eventNameController.text;
    final description = eventDescriptionController.text;
    final eventDate = _selectedDate;
    final startTime = _selectedStartTime;
    final endTime = _selectedEndTime;
    final eventColor = _selectedColor;
    final cid = widget.id;
    final cname = communityName;

    // Fetch the community name asynchronously

    // Await the result to get the community name

    if (name.isNotEmpty &&
        eventDate != null &&
        startTime != null &&
        endTime != null &&
        eventColor != null &&
        cid.isNotEmpty) {
      ref.read(eventControllerProvider.notifier).createEvent(
        name,
        description,
        cid,
        cname,
        eventDate,
        startTime,
        endTime,
        eventColor,
        context,
      );
    }
  },
  icon: const Icon(LineIcons.save),
),

          IconButton(
            onPressed: () {},
            icon: const Icon(LineIcons.alternateTrash),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Event name',
                hintext: 'Enter your event name',
                controller: eventNameController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Event Description',
                hintext: 'Enter your event description',
                controller: eventDescriptionController,
              ),
              const SizedBox(height: 20),
              CustomDateField(
                labelText: 'Event Date',
                icon: const Icon(Icons.calendar_month, color: Colors.black54),
                hintext: DateFormat.yMd().format(_selectedDate!),
                controller: eventDateController,
                onCalendarIconTap: () => _pickDate(context),
              ),
              const SizedBox(height: 20),
              CustomDateField(
                labelText: 'Start time',
                icon: const Icon(Icons.access_time, color: Colors.black54),
                hintext: DateFormat.jm().format(
                  DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedStartTime!.hour,
                    _selectedStartTime!.minute,
                  ),
                ),
                controller:eventStartTimeController,
                onCalendarIconTap: () => _pickTime(context,eventStartTimeController),
              ),
              const SizedBox(height: 20),
              CustomDateField(
                labelText: 'End time',
                icon: const Icon(Icons.access_time, color: Colors.black54),
                hintext: DateFormat.jm().format(
                  DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedEndTime!.hour,
                    _selectedEndTime!.minute,
                  ),
                ),
                controller: eventEndTimeController,
                onCalendarIconTap: () => _pickEndTime(context),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Color:',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: predefinedColors.length,
                  itemBuilder: (context, index) {
                    final color = predefinedColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _selectedColor == color
                              ? Border.all(color: Colors.black, width: 2.0)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> predefinedColors = [
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
];