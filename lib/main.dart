import 'dart:developer';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting().then((value) => runApp(
        MaterialApp(
          //디버그 뱃지 없애기
          debugShowCheckedModeBanner: false,
          home: const MyApp(),
          theme: ThemeData(
              //scaffoldBackgroundColor: Colors.white,
              ),
        ),
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 현재시간
  DateTime today = DateTime.now();

  // 선택 날짜 /  null일 수도 있음
  DateTime? _selectedDay;

  // select 담을 List
  //final List<DateTime> _selectedDates = [];
  final _selectedDates = [];

  // _challengeTitle
  var _text = 'GOAL';

  bool isChecked = false;

  // Selectbox
  Color selectedOption = Colors.indigo;
  List<Color> options = [
    Colors.indigo,
    Colors.amber,
    Colors.blue,
    Colors.greenAccent
  ];

  Color boxColor = Colors.indigo;

  void changeColor() {
    setState(() {
      boxColor = selectedOption;
    });
  }

  // title 변경하는 함수
  void showEditableTextDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //title: const Text('제목을 변경하세요.'),
        content: EditableText(
          controller: TextEditingController(text: _text),
          focusNode: FocusNode(),
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          cursorColor: Colors.red,
          backgroundCursorColor: Colors.black,
          onChanged: (text) {
            setState(() {
              _text = text;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '변경',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //focusedDay 설정 위한 함수
  DateTime getFocusedDay() {
    var focusedDay = today;
    //_selectedDay null이면 today
    focusedDay = _selectedDay ?? today;
    return focusedDay;
  }

  DateTime getFocusedDays() => _selectedDay ?? today;

  String todayChk() => _selectedDates.contains(today) ? "today" : "not today";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      // 상단 타이틀
      // appBar: AppBar(
      //   elevation: 0.3,
      //   title:  Text(
      //     "Daily Stamp",
      //   ),
      //   titleTextStyle:  TextStyle(
      //     color: Colors.black,
      //     fontSize: 25,
      //     fontWeight: FontWeight.w300,
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      // backgroundColor: Colors.amber,
      // 기기 상관없이
      body: SafeArea(
        child: content(),
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //가로로 꽉차게 하기
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          // 제목부분 수정할 수 있도록
          GestureDetector(
            onTap: () {
              showEditableTextDialog(context);
            },
            child: Text(
              _text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // const Text(
          //   "1 MONTH CHALLENGE",
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     color: Colors.black87,
          //     fontSize: 35,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            // deco - box
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child:
                // 캘린더
                TableCalendar(
              //====================================== 필수 ======================================
              //focusedDay: (_selectedDates.last ?? today),
              focusedDay: getFocusedDays(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              //====================================== 한글 적용 ======================================
              locale: 'ko_KR',
              //====================================== 캘린더 높이 ======================================
              rowHeight: 85,
              //====================================== 헤더 스타일 ======================================
              headerStyle: const HeaderStyle(
                // 0000년 00월 00일 << Text Style
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
                headerMargin: EdgeInsets.all(10.0),
                // 2 weeks 안보이기
                formatButtonVisible: false,
                titleCentered: true,
                // formatButtonDecoration: BoxDecoration(
                //   color: Colors.black,
                // ),
                // < > 버튼 없애기
                leftChevronVisible: false,
                rightChevronVisible: false,
              ),
              //====================================== 캘린더 스타일 ======================================
              calendarStyle: const CalendarStyle(
                // 이모티콘 크기 조절을 위한 셀 마진
                //cellMargin: EdgeInsets.all(11.0),
                // cellPadding: EdgeInsets.symmetric(
                //   vertical: 0,
                //   horizontal: 11,
                // ),

                cellMargin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                //캘린더 날짜 위치
                cellAlignment: Alignment.bottomCenter,
                // TODAY ==============================
                todayTextStyle: TextStyle(
                  color: Colors.black,
                  //decoration: TextDecoration.overline,
                ),
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                  shape: BoxShape.rectangle,
                  borderRadius: null,
                  //borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                // selected ===========================
                // selectedDecoration: BoxDecoration(
                //   image: DecorationImage(
                //     fit: BoxFit.contain,
                //     image: AssetImage(
                //       'assets/images/fire.png',
                //     ),
                //   ),
                // ),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo,
                ),
                selectedTextStyle: TextStyle(color: Colors.black),
                // 주말 text color
                weekendTextStyle: TextStyle(color: Colors.black),
                // 다음달 이전달 보이기
                outsideDaysVisible: false,
              ),
              //====================================== 기능 ======================================
              // selectedDayPredicate: (day) => isSameDay(day, today),
              // onDaySelected: _onDaySelected,
              //지정된 날짜를 선택한 날짜로 표시할지 여부를 결정하는 함수
              selectedDayPredicate: (day) => _selectedDates.contains(day),
              //사용자가 달력에서 날짜를 선택할 때마다 호출되는 함수
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  // 이미 선택된 날짜면 삭제
                  if (_selectedDates.contains(selectedDay)) {
                    _selectedDates.remove(selectedDay);
                    // focusedDay 설정
                    _selectedDay = selectedDay;
                    //} else if (selectedDay == focusedDay) {
                    // 선택된 날짜가 아니면 추가
                  } else {
                    _selectedDates.add(selectedDay);
                    // focusedDay 설정
                    _selectedDay = selectedDay;
                  }
                  // log
                  log('selectedDay: $_selectedDay');
                  log('selectedLIST!: $_selectedDates');
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: BorderRadius.all(
              //   Radius.circular(25),
              // ),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Row(
              children: const [
                Text(
                  "Stamp",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                // Center(
                //   child: DropdownButton<Color>(
                //     value: selectedOption,
                //     hint: const Text('Select an option'),
                //     items: options.map((Color option) {
                //       return DropdownMenuItem<Color>(
                //         value: option,
                //         child: Text(option as String),
                //       );
                //     }).toList(),
                //     onChanged: (Color? newValue) {
                //       setState(() {
                //         selectedOption = newValue!;
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
