import 'dart:async';
import 'dart:math';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:crimson_cycle/core/common/provider/dark_theme.dart';
import 'package:crimson_cycle/core/common/snackbar/my_snackbar.dart';
import 'package:crimson_cycle/core/theme/constants/date_utils.dart'
    as date_util;
import 'package:crimson_cycle/features/calendar/presentation/view/calendar_view.dart';
import 'package:crimson_cycle/features/category/presentation/view/add_category_view.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/home_view.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/user_profile_view.dart';
import 'package:crimson_cycle/features/dashboard/presentation/viewmodel/home_viewmodel.dart';
import 'package:crimson_cycle/features/healthInfo/presentation/view/add_healthInfo_view.dart';
import 'package:crimson_cycle/features/order/presentation/view/order_view.dart';
import 'package:crimson_cycle/features/product/presentation/view/add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  double width = 1;
  double height = 0.0;
  late ScrollController scrollController;
  late bool isDark = false;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();
  int key = 10;
  Map<String, double> dataMap = {
    'Days since Last Period': 10,
    'Days until Next Period': 30,
  };
  List<Color> colorList = [
    const Color.fromARGB(255, 123, 159, 177),
    const Color.fromARGB(255, 148, 211, 240),
  ];

  bool isNotificationOn = true;

  bool isFavourite1 = false;
  bool isFavourite2 = false;
  bool isFavourite3 = false;
  bool isFavourite4 = false;

  bool showMoreItems = false;

  bool _isNear = false;
  final List<StreamSubscription<dynamic>> _streamSubscriptions = [];

  // State variable for the current index
  int _selectedIndex = 0;
  bool _logoutPromptShown = false;
  bool _changeThemePromptShown = false;
  final double shakeThreshold = 2.0;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  DateTime? _lastShakeTime;

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);

    super.initState();
    _accelerometerSubscription =
        accelerometerEvents!.listen((AccelerometerEvent event) {
      final DateTime now = DateTime.now();
      final double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z) -
              9.81;

      if (_lastShakeTime == null ||
          now.difference(_lastShakeTime!).inSeconds > 2) {
        // Debounce time
        if (acceleration > shakeThreshold && !_logoutPromptShown) {
          _lastShakeTime = now;
          _showLogoutPrompt();
        }
      }
    });

    _streamSubscriptions.add(proximityEvents!.listen((event) {
      setState(() {
        _isNear = event.getValue();
        if (!_isNear) {
          _changeThemePromptShown = false;
        }
      });
    }));
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    for (var subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _showLogoutPrompt() {
    if (!_logoutPromptShown) {
      _logoutPromptShown = true;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Logout"),
              content: const Text("Do you want to log out?"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text("Logout"),
                  onPressed: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    await ref
                        .read(homeViewModelProvider.notifier)
                        .logout(context);
                    if (context.mounted) {
                      showSnackBar(
                        message: 'Logging out...',
                        context: context,
                        color: Colors.red,
                      );
                    }
                  },
                ),
              ],
            );
          }).then((_) {
        setState(() {
          _logoutPromptShown = false;
        });
      });
    }
  }

  void showChangeThemePrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change theme"),
          content: const Text("Do you want to change theme?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Change"),
              onPressed: () async {
                Navigator.of(context).pop();
                final isDarkModeEnabled =
                    ref.read(isDarkThemeProvider.notifier).state;
                await ref
                    .read(isDarkThemeProvider.notifier)
                    .updateTheme(!isDarkModeEnabled);
                if (context.mounted) {
                  showSnackBar(
                    message: 'Theme changed...',
                    context: context,
                    color: isDarkModeEnabled ? Colors.black : Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // A method to return the widget based on the selected index
  Widget getWidgetForIndex(int index) {
    switch (index) {
      case 0:
        return const HomePageContent();
      case 1:
        return CalendarWithEvents();
      case 2:
        return const AddCategoryView();
      case 3:
        return const ProductAddView();
      case 4:
        // return const HealthInfoView();
      default:
        return const Text('Page Not Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isNear && !_changeThemePromptShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isNear && !_changeThemePromptShown) {
          _changeThemePromptShown =
              true; // Set the flag to true to prevent multiple dialogs
          showChangeThemePrompt();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                key = key + 1;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              await ref.read(homeViewModelProvider.notifier).logout(context);
              if (context.mounted) {
                showSnackBar(
                  message: 'Loggin out...',
                  context: context,
                  color: Colors.red,
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: getWidgetForIndex(_selectedIndex),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).drawerTheme.backgroundColor ??
                Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVs2sVWK6cvNuxPcjSAhYbVGbQXWwXYECjPQ&usqp=CAU',
                        ),
                      ),
                      onTap: () {
                        // Handle the tap event
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserProfileView()));
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Asmita',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.note),
                title: const Text('Notes'),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment'),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Wishlist'),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Your Reports'),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.healing),
                title: const Text('Health'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderView()), // Replace YourNewPage with the actual page you want to navigate to
                  );
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Theme Light/Dark'),
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                    ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                  });
                },
              ),
              ListTile(
                title: const Row(
                  children: [
                    Text('Privacy Policy'),
                    SizedBox(width: 5),
                    Text(
                      '|',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    Text('Logout'),
                  ],
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(231, 237, 245, 10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: GNav(
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            backgroundColor: const Color.fromRGBO(231, 237, 245, 10),
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blue.shade100,
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.calendar_month, text: "Calendar"),
              GButton(icon: Icons.money, text: "Buy"),
              GButton(icon: Icons.medical_services, text: "Doctor"),
              GButton(icon: Icons.medical_services, text: "Product"),
            ],
          ),
        ),
      ),
    );
  }
}
