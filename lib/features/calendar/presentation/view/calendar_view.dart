// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarView extends StatefulWidget {
//   const CalendarView({super.key});

//   @override
//   _CalendarViewState createState() => _CalendarViewState();
// }

// class _CalendarViewState extends State<CalendarView> {
//   Map<String, dynamic> response = {
//     "_id": "65dc23d1c5a4c9d5fefe4061",
//     "userId": "65c77c4f372cdae5f698bc14",
//     "__v": 0,
//     "createdAt": "2024-02-26T05:38:26.542Z",
//     "events": [
//       {
//         "type": "periodStart",
//         "date": "2024-03-15T00:00:00.000Z",
//         "_id": "65dc2b437519fe5ef437d9cd"
//       },
//       {
//         "type": "periodEnd",
//         "date": "2024-03-17T00:00:00.000Z",
//         "_id": "65dc2b437519fe5ef437d9ce"
//       },
//       {
//         "type": "ovulationDay",
//         "date": "2024-03-01T00:00:00.000Z",
//         "_id": "65dc2b437519fe5ef437d9cf"
//       },
//       {
//         "type": "fertileWindowStart",
//         "date": "2024-02-25T00:00:00.000Z",
//         "_id": "65dc2b437519fe5ef437d9d0"
//       },
//       {
//         "type": "fertileWindowEnd",
//         "date": "2024-03-01T00:00:00.000Z",
//         "_id": "65dc2b437519fe5ef437d9d1"
//       }
//     ],
//     "updatedAt": "2024-02-26T06:10:11.024Z"
//   };

//   Map<DateTime, List<dynamic>> parseEvents(Map<String, dynamic> response) {
//     Map<DateTime, List<dynamic>> eventMap = {};
//     List events = response['events'];
//     DateTime? periodStart;
//     DateTime? lastDay; // You can adjust this date as needed

//     for (var event in events) {
//       DateTime date = DateTime.parse(event['date']).toUtc();
//       // Remove the time part to avoid issues with events appearing on the wrong day due to time zones
//       DateTime dateWithoutTime = DateTime.utc(date.year, date.month, date.day);

//       if (eventMap[dateWithoutTime] == null) {
//         eventMap[dateWithoutTime] = [];
//       }
//       eventMap[dateWithoutTime]!.add(event["type"]);

//       if (event["type"] == "periodStart") {
//         periodStart = dateWithoutTime;
//       }
//       if (event["type"] == "periodEnd") {
//         lastDay = dateWithoutTime;
//       }
//     }
//     if (periodStart != null && lastDay != null) {
//       DateTime currentPeriodStart = periodStart;
//       while (currentPeriodStart.isBefore(lastDay)) {
//         for (int i = 0; i < _periodLength; i++) {
//           DateTime currentDay = currentPeriodStart.add(Duration(days: i));
//           // Check if the list for the currentDay already exists, if not create it
//           eventMap[currentDay] = (eventMap[currentDay] ?? [])..add("Period");
//         }
//         // Predicted period for the next cycle, adjust currentPeriodStart for the next iteration
//         currentPeriodStart =
//             currentPeriodStart.add(Duration(days: _cycleLength));
//       }
//     }

//     return eventMap;
//   }

//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   // Example period data, you would fetch this from user input or a database
//   final DateTime _startPeriodDate =
//       DateTime(DateTime.now().year, DateTime.now().month, 5);
//   final int _periodLength = 5; // Typical period length in days
//   final int _cycleLength = 28; // Typical cycle length in days

//   List<dynamic> _getEventsForDay(DateTime day) {
//     final List<dynamic> events = [];

//     // Calculate period days for the current and next months
//     DateTime periodStart = _startPeriodDate;
//     DateTime lastDay =
//         DateTime.utc(2040, 12, 31); // You can adjust this date as needed

//     while (periodStart.isBefore(lastDay)) {
//       for (int i = 0; i < _periodLength; i++) {
//         DateTime currentDay = periodStart.add(Duration(days: i));
//         if (isSameDay(day, currentDay)) {
//           // If the currentDay is in the current month, it's a period; otherwise, it's a predicted period.
//           if (currentDay.month == _startPeriodDate.month &&
//               currentDay.year == _startPeriodDate.year) {
//             events.add('Period');
//           } else {
//             events.add('Predicted');
//           }
//         }
//       }
//       // Predicted period for the next cycle
//       periodStart = periodStart.add(Duration(days: _cycleLength));
//     }

//     // Calculate fertile window for the current and next months
//     DateTime fertileStart = _startPeriodDate.add(
//         const Duration(days: 14)); // Approximately 2 weeks after period start
//     while (fertileStart.isBefore(lastDay)) {
//       if (day.isAfter(fertileStart.subtract(const Duration(days: 5))) &&
//           day.isBefore(fertileStart.add(const Duration(days: 5)))) {
//         events.add('Fertile');
//       }
//       // Predicted next fertile window
//       fertileStart = fertileStart.add(Duration(days: _cycleLength));
//     }
//     print(events);
//     print(events.length);
//     return events;
//   }

//   late Map<DateTime, List<dynamic>> _events;

//   @override
//   void initState() {
//     super.initState();
//     // Assuming `response` is available here. Otherwise, pass it to the widget.
//     _events = parseEvents(response);
//     print(_events);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("BUILD 1");

//     return Column(
//       children: [
//         TableCalendar(
//           firstDay: DateTime.utc(2020, 1, 1),
//           lastDay: DateTime.utc(2040, 12, 31),
//           focusedDay: _focusedDay,
//           selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//           onDaySelected: (selectedDay, focusedDay) {
//             if (!isSameDay(_selectedDay, selectedDay)) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });
//             }
//           },
//           eventLoader: (day) {
//             // Use `day` to get events from `_events` map
//             return _events[day] ?? [];
//           },
//           calendarStyle: const CalendarStyle(
//             // Define markers for period and fertile window
//             markerDecoration: BoxDecoration(
//               color: Colors.transparent,
//             ),
//             outsideDaysVisible: false,
//           ),
//           calendarBuilders: CalendarBuilders(
//             markerBuilder: (context, date, events) {
//               if (events.contains('Period')) {
//                 return Container(
//                   margin: const EdgeInsets.all(4.0),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromARGB(255, 248, 187, 208),
//                   ),
//                   width: 16.0,
//                   height: 16.0,
//                 );
//               } else if (events.contains('ovulationDay')) {
//                 return Container(
//                   margin: const EdgeInsets.all(4.0),
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color.fromARGB(255, 161, 119, 232)),
//                   width: 16.0,
//                   height: 16.0,
//                 );
//               } else if (events.contains('Fertile')) {
//                 return Container(
//                   margin: const EdgeInsets.all(4.0),
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.lime),
//                   width: 16.0,
//                   height: 16.0,
//                 );
//               } else if (events.isNotEmpty) {
//                 return Container(
//                   margin: const EdgeInsets.all(4.0),
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.black),
//                   width: 16.0,
//                   height: 16.0,
//                 );
//               }
//               return null;
//             },
//           ),
//         ),
//         // Add a legend for the colors
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildLegend('Period', const Color.fromARGB(255, 248, 187, 208)),
//               _buildLegend('Fertile Window', Colors.lime),
//               _buildLegend(
//                   'Predicted', const Color.fromARGB(255, 161, 119, 232))
//               // Add more legends if needed
//             ],
//           ),
//         ),
//         ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pushNamed("/graph");
//             },
//             child: const Text("View graphs"))
//       ],
//     );
//   }

//   Widget _buildLegend(String text, Color color) {
//     return Row(
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           margin: const EdgeInsets.only(right: 8.0),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//         Text(text),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWithEvents extends StatefulWidget {
  @override
  _CalendarWithEventsState createState() => _CalendarWithEventsState();
}

class _CalendarWithEventsState extends State<CalendarWithEvents> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    _populateEvents();
  }

  void _populateEvents() {
    // Your backend response
    Map<String, dynamic> response = {
      "events": [
        {"type": "periodStart", "date": "2024-03-15"},
        {"type": "periodEnd", "date": "2024-03-17"},
        {"type": "ovulationDay", "date": "2024-03-01"},
        {"type": "fertileWindowStart", "date": "2024-02-25"},
        {"type": "fertileWindowEnd", "date": "2024-03-01"},
      ],
    };

    response['events'].forEach((event) {
      DateTime date = DateTime.parse(event['date']);
      final eventType = event['type'];
      Color color;
      switch (eventType) {
        case 'periodStart':
        case 'periodEnd':
          color = Colors.pink;
          break;
        case 'fertileWindowStart':
        case 'fertileWindowEnd':
          color = Colors.lime;
          break;
        case 'ovulationDay':
          color = Colors.blue;
          break;
        default:
          color = Colors.grey;
      }
      if (selectedEvents[date] == null) selectedEvents[date] = [];
      selectedEvents[date]!.add(Event(title: eventType, color: color));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar With Events'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2025, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format;
          });
        },
        eventLoader: (day) {
          return selectedEvents[day] ?? [];
        },
        calendarStyle: CalendarStyle(
          // Customize calendar style
          markerDecoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final Color color;

  Event({required this.title, required this.color});
}
