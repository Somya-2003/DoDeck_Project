import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'task_details.dart';

class Settings extends StatefulWidget{
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{
  late Database _database;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Done')),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => TaskDetails(database: _database)));
            }, child: Text('Manage Task')),
          ],
        ),
      ),
    );
  }
}



//THEME PROVIDER

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'theme_provider.dart';
// import 'theme_style.dart';
//
// class Settings extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Settings")),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 themeProvider.setTheme(ThemeClass.lightTheme);
//               },
//               child: Text('Light Theme')),
//
//           ElevatedButton(
//               onPressed: () {
//                 themeProvider.setTheme(ThemeClass.darkTheme);
//               },
//               child: Text('Dark Theme')),
//
//           ElevatedButton(
//               onPressed: () {
//                 themeProvider.setTheme(ThemeClass.pinkTheme);
//               },
//               child: Text('Pink Theme')),
//
//           ElevatedButton(
//               onPressed: () {
//                 themeProvider.setTheme(ThemeClass.greenTheme);
//               },
//               child: Text('Green Theme')),
//
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Done')),
//         ],
//       ),
//     );
//   }
// }


