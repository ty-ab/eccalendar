// import 'package:abushakir/abushakir.dart';
// import 'package:eccalendar/screens/date_details.dart';
// import 'package:eccalendar/state/state_manager.dart';
// import 'package:eccalendar/utils/themedata_extension.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../utils/eth_utils.dart';

// class EthMonthlyView extends StatefulWidget {
//   EtDatetime month = EtDatetime.now();
//   final void Function(EtDatetime date) onPageChanged;

//   EthMonthlyView({super.key, required month, required this.onPageChanged});
//   @override
//   _EthMonthlyViewState createState() => _EthMonthlyViewState();
// }

// class _EthMonthlyViewState extends State<EthMonthlyView> {
//   EtDatetime _selectedtDate = EtDatetime.now(); //

//   late final PageController _pageController = PageController(
//     initialPage: EthUtils.initialPage,
//   );

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _goToPreviousMonth() {
//     _pageController.previousPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _goToNextMonth() {
//     _pageController.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
//     final colorScheme = Theme.of(context).colorScheme;
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Expanded(flex: 1, child: _buildWeekdayHeaders(2)),
//         Expanded(
//           flex: 5,
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
//             padding: const EdgeInsets.all(5),

//             decoration: BoxDecoration(
//               color: colorScheme.surface,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 2,
//                   offset: Offset(0, 1),
//                 ),
//               ],
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10),
//               ),
//             ),
//             child: PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.horizontal,
//               dragStartBehavior: DragStartBehavior.down,
//               pageSnapping: true,
//               key: ValueKey(widget.month.month),
//               scrollBehavior: ScrollBehavior(),
//               onPageChanged: (value) {
//                 setState(() {
//                   widget.onPageChanged(widget.month);
//                   print("DAY:${value}");
//                 });
//               },
//               itemBuilder: (context, index) {
//                 widget.month = EtDatetime(
//                   year:
//                       EtDatetime.now().year +
//                       (index - EthUtils.initialPage) ~/ 12,
//                   month:
//                       EtDatetime.now().month +
//                       (index - EthUtils.initialPage) % 13,
//                   day: 1,
//                 );

//                 print("DAY2INDEX:${widget.month}");

//                 return MonthlyCalendarView(
//                   month: widget.month,
//                   onDateSelected: (EtDatetime date) {
//                     setState(() {
//                       _selectedtDate = date;
//                     });
//                   },
//                   // prevMonthCallback: _goToPreviousMonth,
//                   // nextMonthCallback: _goToNextMonth,
//                 );
//               },
//             ),
//           ),
//         ),
// Consumer<EtDatetime>(
//   builder: (context, value, child) {
//        return Expanded(
//           flex: 4,
//           child: Text(
//             '$value : ${EthUtils.dayEvent(value).toString()}',
//           ),
//         );
    
//   },
// ),
//       ],
//     );
//   }

//   Widget _buildWeekdayHeaders(int startOfWeek) {
//     final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
//     final colorScheme = Theme.of(context).colorScheme;
//     // Generate weekday names starting from custom start day
//     final weekdays = List.generate(7, (index) {
//       final weekday =
//           (startOfWeek - 1 + index) % 7 + 1; // Calculate weekday number
//       return DateFormat(
//         'E',
//       ).format(DateTime(2023, 1, weekday)); // Any date with known weekday
//     });

//     return Container(
//       margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
//       padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
//         ],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       child: Table(
//         children: [
//           TableRow(
//             children:
//                 weekdays
//                     .map(
//                       (day) => Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           day,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: colorScheme.onSurface,
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MonthlyCalendarView extends StatefulWidget {
//   final EtDatetime month;
//   final void Function(EtDatetime date) onDateSelected;
//   // final VoidCallback prevMonthCallback;
//   // final VoidCallback nextMonthCallback;

//   MonthlyCalendarView({
//     super.key,
//     required this.month,
//     required this.onDateSelected,
//     // required this.prevMonthCallback,
//     // required this.nextMonthCallback,
//   });

//   @override
//   State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
// }

// class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
//   EtDatetime selectedDate = EtDatetime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       border: TableBorder.symmetric(),
//       children: _buildCalendarRows(),
//     );
//   }

//   List<TableRow> _buildCalendarRows() {
//     // Create list of days to display (including leading/trailing days from other months)
//     final List<_DayCell> days = _generateMonthDays(widget.month);
//     // Build table rows
//     final rows = <TableRow>[];

//     // Add day cells
//     for (var i = 0; i < days.length; i += 7) {
//       final week = days.sublist(i, i + 7);

//       rows.add(
//         TableRow(children: week.map((date) => _buildDayCell(date)).toList()),
//       );
//     }

//     return rows;
//   }

//   Widget _buildDayCell(_DayCell cellDate) {
//     final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
//     final colorScheme = Theme.of(context).colorScheme;

//     final EtDatetime today = EtDatetime.now();
//     final isToday = EthUtils.isSameDay(cellDate.date, today);
//     final isSelected = EthUtils.isSameDay(cellDate.date, selectedDate);
//     return GestureDetector(
//       onTap: () {
//         // setState(() {
//         //   selectedDate = cellDate.date;
//         // });
//         // widget.onDateSelected.call(selectedDate);
//         if (isSelected) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EtDateDetails(selectedDate: cellDate.date),
//             ),
//           );
//         }
//       },
//       child: Container(
//         alignment: Alignment.center,
//         margin: const EdgeInsets.all(1),
//         padding: const EdgeInsets.all(2),
//         height: 55,
//         width: 65,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color:
//                 isSelected ? calendarTheme.selectedDayColor : Color(0x00000000),
//           ),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,

//           children: [
//             Container(
//               alignment: Alignment.center,
//               // margin: const EdgeInsets.only(top: 2),
//               decoration: BoxDecoration(
//                 color: isToday ? Colors.cyan : null,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               width: 25,
//               child: Text(
//                 '${cellDate.date.day}',
//                 style: TextStyle(
//                   color:
//                       cellDate.isCurrentMonth
//                           ? isToday
//                               ? Colors.white
//                               : colorScheme.primary
//                           : Colors.grey,
//                   fontWeight:
//                       cellDate.isCurrentMonth
//                           ? FontWeight.w400
//                           : FontWeight.w300,
//                   fontSize: 16.5,
//                 ),
//               ),
//             ),

//             Container(
//               alignment: Alignment.bottomRight,
//               margin: const EdgeInsets.only(top: 0),
//               // width: 6,
//               // height: 6,
//               child: Text(
//                 DateTime.fromMillisecondsSinceEpoch(
//                   cellDate.date.moment,
//                 ).day.toString(),
//                 style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//               ),
//             ),
//             cellDate.hasEvents
//                 ? Container(
//                   alignment: Alignment.bottomLeft,
//                   // margin: const EdgeInsets.only(top: 2),
//                   width: 50,
//                   height: 2,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     color: Colors.blue,
//                   ),
//                 )
//                 : Container(
//                   alignment: Alignment.bottomLeft,
//                   margin: const EdgeInsets.only(top: 2),
//                   width: 50,
//                   height: 2,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<_DayCell> _generateMonthDays(EtDatetime month) {
//     final firstDay = EtDatetime(year: month.year, month: month.month);
//     final startWeekDay = firstDay.weekday % 7;
//     final totalDays =
//         ETC(year: month.year, month: month.month).monthDays().length;

//     //prev month
//     final EtDatetime prevMonth;
//     if (month.month - 1 == 0) {
//       prevMonth = EtDatetime(year: month.year - 1, month: 13);
//     } else {
//       prevMonth = EtDatetime(year: month.year, month: month.month - 1);
//     }
//     final prevMonthDays =
//         ETC(year: prevMonth.year, month: prevMonth.month).monthDays().length +
//         1;
//     final leadingDays = [
//       for (int i = startWeekDay; i > 0; i--)
//         _DayCell(
//           date: EtDatetime(
//             year: prevMonth.year,
//             month: prevMonth.month,
//             day: prevMonthDays - i,
//           ),
//           isCurrentMonth: false,
//         ),
//     ];
//     //current month
//     final currentDays = [
//       for (int d = 1; d <= totalDays; d++)
//         _DayCell(
//           date: EtDatetime(year: month.year, month: month.month, day: d),
//           isCurrentMonth: true,
//         ),
//     ];
//     // Next month
//     final trailingNeeded =
//         EthUtils.dayGrid - (leadingDays.length + currentDays.length);
//     final nextMonth = EtDatetime(year: month.year, month: month.month + 1);
//     final trailingDays = [
//       for (int d = 1; d <= trailingNeeded; d++)
//         _DayCell(
//           date: EtDatetime(
//             year: nextMonth.year,
//             month: nextMonth.month,
//             day: d,
//           ),
//           isCurrentMonth: false,
//         ),
//     ];
//     return [...leadingDays, ...currentDays, ...trailingDays];
//   }
// }

// List loadEvents(List<_DayCell> dayCells) {
//   return dayCells.map((element) {
//     return EthUtils.dayEvent(element.date);
//   }).toList();
// }

// class _DayCell {
//   final EtDatetime date;
//   final bool isCurrentMonth;
//   _DayCell({required this.date, required this.isCurrentMonth});
//   bool get hasEvents {
//     return EthUtils.dayEvent(date).isNotEmpty;
//   }
// }

// // extension on EtDatetime {
// //   int get days {
// //     return ETC(year: year, month: month).monthDays().length;
// //   }
// // }
