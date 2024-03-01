// import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
// import 'package:crimson_cycle/core/theme/constants/fonts.dart';
// import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
// import 'package:crimson_cycle/features/healthInfo/presentation/view_model/healthInfo_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HealthInfoView extends ConsumerStatefulWidget {
//   const HealthInfoView({Key? key}) : super(key: key);

//   @override
//   ConsumerState<HealthInfoView> createState() => _HealthInfoViewState();
// }

// class _HealthInfoViewState extends ConsumerState<HealthInfoView> {
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _lastPeriodDateController =
//       TextEditingController();
//   final TextEditingController _periodDaysController = TextEditingController();
//   final TextEditingController _periodIntervalController =
//       TextEditingController();
//   bool _isRegularPeriod = false;
//   bool _easyPeriod = false;
//   int? _selectedPeriodInterval = 28;

//   final _formKey = GlobalKey<FormState>();
//   DateTime? _lastPeriodDate;
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserId();
//   }

//   Future<void> _fetchUserId() async {
//     final userPrefs = ref.read(userSharedPrefsProvider);
//     final userIdResult = await userPrefs.getUserId();

//     userIdResult.fold(
//       (failure) {},
//       (userId) {
//         if (mounted) {
//           setState(() {
//             _userId = userId;
//           });
//         }
//       },
//     );
//   }

//   void _submitForm(userId) {
//     print("UER ID::${userId.toString()}");
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('User ID is not available. Please log in again.')),
//       );
//       return;
//     }

//     if (_formKey.currentState?.validate() ?? false) {
//       final healthInfo = HealthInfoEntity(
//         userId: userId.toString(),
//         age: int.parse(_ageController.text),
//         height: int.parse(_heightController.text.toString()),
//         weight: int.parse(_weightController.text),
//         lastPeriodDate: _lastPeriodDate ?? DateTime.now(),
//         periodDays: int.parse(_periodDaysController.text.toString()),
//         periodInterval: _periodIntervalController.text == ''
//             ? 3
//             : int.parse(_periodIntervalController.text.toString()),
//         isRegularPeriod: _isRegularPeriod,
//         hasCramps: _easyPeriod,
//       );

//       ref
//           .read(healthInfoViewModelProvider(userId!).notifier)
//           .addOrUpdateHealthInfo(healthInfo);
//       // Consider navigating the user or showing a success message after submission
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Ensure _userId is not null before using it to watch or read providers
//     print(_userId);
//     return Scaffold(
//       appBar: AppBar(title: const Text("Health Info")),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: "Period Tracker Details\n",
//                     style: titleFont,
//                     children: const <TextSpan>[
//                       TextSpan(
//                         text: 'Enter your period details',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _ageController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     label: Text("Age", style: normalFont),
//                     prefixIcon: const Icon(Icons.calendar_today),
//                     hintText: "Enter your age",
//                     hintStyle: normalFont,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your age';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _heightController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     label: Text("Height (cm)", style: normalFont),
//                     prefixIcon: const Icon(Icons.height),
//                     hintText: "Enter your height",
//                     hintStyle: normalFont,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your height';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _weightController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     label: Text("Weight (kg)", style: normalFont),
//                     prefixIcon: const Icon(Icons.line_weight),
//                     hintText: "Enter your weight",
//                     hintStyle: normalFont,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your weight';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                   onTap: () => _selectLastPeriodDate(context),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       controller: _lastPeriodDateController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(width: 2, color: Colors.white),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(width: 2, color: Colors.white),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         label: Text("Last Period Date", style: normalFont),
//                         prefixIcon: const Icon(Icons.calendar_today),
//                         hintText: "Select the date",
//                         hintStyle: normalFont,
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select the last period date';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _periodDaysController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     label: Text("Period Days", style: normalFont),
//                     prefixIcon: const Icon(Icons.calendar_today),
//                     hintText: "Enter the number of days",
//                     hintStyle: normalFont,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the number of days';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 DropdownButtonFormField<int>(
//                   value: _selectedPeriodInterval,
//                   items: [21, 28, 30, 35].map((interval) {
//                     return DropdownMenuItem<int>(
//                       value: interval,
//                       child: Text('$interval days'),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedPeriodInterval = value;
//                       _periodIntervalController.text = value.toString();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     label: Text("Period Interval (days)", style: normalFont),
//                     prefixIcon: const Icon(Icons.calendar_today),
//                     hintText: "Select the interval",
//                     hintStyle: normalFont,
//                   ),
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select the period interval';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: _isRegularPeriod,
//                       onChanged: (value) {
//                         setState(() {
//                           _isRegularPeriod = value!;
//                         });
//                       },
//                     ),
//                     Text("Is your period regular?", style: normalFont),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: _easyPeriod,
//                       onChanged: (value) {
//                         setState(() {
//                           _easyPeriod = value!;
//                         });
//                       },
//                     ),
//                     Text("Do you get cramps?", style: normalFont),
//                   ],
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                     style: OutlinedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {
//                       print("BUTTON PRESSED::");
//                       _submitForm(_userId);
//                     },
//                     child: const Text(
//                       "Save and Login",
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _selectLastPeriodDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _lastPeriodDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _lastPeriodDate = pickedDate;
//         _lastPeriodDateController.text = pickedDate.toIso8601String();
//       });
//     }
//   }
// }
