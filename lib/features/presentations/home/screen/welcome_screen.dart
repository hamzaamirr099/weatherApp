// import 'package:flutter/material.dart';
// import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
//
// import '../../../../core/shared/functions.dart';
// import '../../../../core/widgets/default_text_field.dart';
//
// class WelcomeScreen extends StatelessWidget {
//
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     MainCubit mainCubit = MainCubit.get(context);
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Welcome to Weather App",
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               DefaultFormField(
//                 hintText: "Enter a location...",
//                 controller: mainCubit.countryNameController,
//                 onFieldSubmitted: (value) {
//                   if (value!.isNotEmpty) {
//                     mainCubit.getWeatherData(
//                         countryName:
//                         mainCubit.countryNameController.text);
//                   } else {
//                     showToastMessage(message: "Enter a location");
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               if (state is LoadingState)
//                 const LinearProgressIndicator(
//                   color: Colors.amberAccent,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
