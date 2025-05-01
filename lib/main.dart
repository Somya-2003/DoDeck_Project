import 'package:dodeck_project/home.dart';
import 'package:dodeck_project/user_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'theme_style.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{

  Future<bool> checkLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_login") ?? false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink,)
      ),
      home: FutureBuilder(
          future: checkLoginStatus() ,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            else{
              return snapshot.data! ? HomeScreen() : LoginScreen();
            }
          },
      ),
    );
  }
}






// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   // ThemeData _currentTheme = ThemeClass.lightTheme;
//   //
//   // void _setTheme(ThemeData theme) {
//   //   setState(() {
//   //     _currentTheme = theme;
//   //   });
//   // }



//USING PROVIDER THEME

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'theme_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'theme_style.dart';
// import 'home.dart';
// import 'user_login.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final themeProvider = ThemeProvider(ThemeClass.lightTheme);
//   await themeProvider.loadTheme(); // Load saved theme
//
//   runApp(
//     ChangeNotifierProvider<ThemeProvider>.value(
//       value: themeProvider,
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   Future<bool> checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool("is_login") ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return MaterialApp(
//       title: 'DoDeck App',
//       theme: themeProvider.themeData,
//       home: FutureBuilder<bool>(
//         future: checkLoginStatus(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else {
//             return snapshot.data! ? HomeScreen() :  LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }