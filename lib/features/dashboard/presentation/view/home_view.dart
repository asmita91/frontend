import 'package:crimson_cycle/core/theme/constants/colors.dart';
import 'package:crimson_cycle/core/theme/constants/date_utils.dart'
    as date_util;
import 'package:crimson_cycle/features/dashboard/presentation/view/article_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePageContent extends ConsumerStatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomePageContent> {
  double width = 1;
  double height = 0.0;

  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();
  int key = 10;
  Map<String, double> dataMap = {
    'Days since Last Period': 10,
    'Days until Next Period': 30,
  };

  bool isNotificationOn = true;

  bool isFavourite1 = false;
  bool isFavourite2 = false;
  bool isFavourite3 = false;
  bool isFavourite4 = false;

  bool showMoreItems = false;

  final bool _isNear = false;

  @override
  void initState() {
    super.initState();

    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
  }

  Widget titleView() {
    return Text(
      date_util.DateUtils.months[currentDateTime.month - 1] +
          ' ' +
          currentDateTime.year.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      width: width,
      height: MediaQuery.of(context).size.height * 0.10,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 4, 4),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (currentMonthList[index].day != currentDateTime.day)
                ? [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.6)
                  ]
                : [HexColor("ED6184"), HexColor("EF315B"), HexColor("E2042D")],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 2),
              blurRadius: 4,
              color: Colors.black12,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currentMonthList[index].day.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("465876")
                      : Colors.white,
                ),
              ),
              Text(
                date_util
                    .DateUtils.weekdays[currentMonthList[index].weekday - 1],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("465876")
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topView() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height * 0.5;
    return Container(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            titleView(),
            hrizontalCapsuleListView(),
          ],
        ),
      ),
    );
  }

  Widget pie() {
    return PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 2000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      ringStrokeWidth: 32,
      colorList: const [
        Color.fromARGB(255, 123, 159, 177),
        Color.fromARGB(255, 148, 211, 240),
      ],
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesOutside: false,
        showChartValuesInPercentage: false,
        showChartValueBackground: false,
        showChartValues: false,
        chartValueStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerText: '10 days',
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendPosition: LegendPosition.right,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Row(
            children: [
              Text(
                'Did you know?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0, right: 8.0),
          child: Text(
              "\"On average a woman menstruates for about 7 years during their lifetime.\""),
        ),
        const SizedBox(
          height: 10,
        ),
        topView(),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(231, 237, 245, 10),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: pie(),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Row(
            children: [
              Text(
                'See Articles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: ArticleView()),
      ],
    );
  }
}
