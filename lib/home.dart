//
// import 'package:dodeck_project/task_details.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// import 'task_list.dart';
// import 'setting_s.dart';
// import 'user_login.dart';
//
// class HomeScreen extends StatefulWidget{
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
//
// }
//
// class _HomeScreenState extends State<HomeScreen>{
//
//   late Database _database;
//
//   String sqlCreate = "CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT )";
//
//   void logout(BuildContext context) async{
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool("is_login", false);
//
//     Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (_) => LoginScreen()),
//     );
//   }
//
//   Future<void> _initDatabase() async{
//     String path = join(await getDatabasesPath(), "task.db");
//
//     _database = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (db, version){
//           return db.execute(sqlCreate);
//         },
//     );
//   }
//
//   void initState(){
//     super.initState();
//     _initDatabase();
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text('HomeScreen')),
//       drawer: Drawer(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(onPressed: (){
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => HomeScreen()));
//               }, child: Text("Home")),
//               SizedBox(height: 10,),
//               ElevatedButton(onPressed: (){
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => AddTaskScreen(database: _database)));
//               }, child: Text("Add Task")),
//               SizedBox(height: 10,),
//               ElevatedButton(onPressed: (){
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => TaskDetails(database: _database)));
//               }, child: Text("Show Task")),
//               SizedBox(height: 10,),
//               ElevatedButton(onPressed: (){
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => Settings()));
//               }, child: Text("Settings")),
//               SizedBox(height: 10,),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.logout),
//                 label: Text("Logout"),
//                 onPressed: () => logout(context),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                   backgroundColor: Colors.pink[200]
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   width: 170,
//                   height: 170,
//                   color: Colors.pink,
//                   child: Center(child:
//                   Text("Welcome " ,
//                     textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 40,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.white,   // Color of text
//                   ),),),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   width: 150,
//                   height: 150,
//                   color: Colors.pink[300],
//                   child: Center(child: Text("Back " , textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 40,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.white,   // Color of text
//                   ),),),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(5),
//                   width: 300,
//                   height: 50,
//                   color: Colors.pink[100],
//                   child: Center(child: Text(" SOMYA " ,textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 30,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.pink,   // Color of text
//                   ),),),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   width: 130,
//                   height: 130,
//                   color: Colors.pink[400],
//                   child: Center(child: Text("Let's" , textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 30,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.white,   // Color of text
//                   ),),),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(1),
//                   width: 180,
//                   height: 180,
//                   color: Colors.pink[800],
//                   child: Center(child: Text("Manage " , textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 45,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.pink[100],   // Color of text
//                   ),),),
//                 ),
//
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   width: 130,
//                   height: 250,
//                   color: Colors.pink[100],
//                   child: Center(child: Text(" Your " , textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 40,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.pink[800],   // Color of text
//                   ),),),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   width: 120,
//                   height: 170,
//                   color: Colors.pink[500],
//                   child: Center(child: Text("Tasks " , textDirection: TextDirection.ltr,style: TextStyle(
//                     fontSize: 30,          // Size of text
//                     fontWeight: FontWeight.bold, // Font weight (bold, normal, etc.)
//                     color: Colors.white,   // Color of text
//                   ),),),
//                 ),
//               ],
//             ),
//           ],
//         ),
//        ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: 'btn1', // Important to avoid heroTag conflicts
//             splashColor: Colors.pink[200],
//             onPressed: () {
//               // Action 1
//               Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => AddTaskScreen(database: _database),
//                         )
//                         );
//             },
//             child: Icon(Icons.add, color: Colors.pink,),
//           ),
//           const SizedBox(height: 10), // spacing between FABs
//           FloatingActionButton(
//             heroTag: 'btn2',
//             splashColor: Colors.pink[200],
//             onPressed: () {
//               // Action 2
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => TaskDetails(database: _database),
//                   )
//               );
//             },
//             child: Icon(Icons.visibility , color: Colors.pink,),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:dodeck_project/task_details.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'theme_style.dart';

///When you moved them to a new file, you also need to import that file
/// wherever you're trying to use those classes.
import 'task_list.dart';
import 'setting_s.dart';
import 'user_login.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  //final Function(ThemeData) onThemeChange;
  //const _HomeScreenState({super.key, required this.onThemeChange});

  late Database _database;

  String sqlCreate = "CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT )";

  bool _isExpanded = false; // Controls animation state

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_login", false);

    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), "task.db");

    _database = await openDatabase(
      path,
      version: 2, // 👈 Increment the version to trigger `onUpgrade`
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, completion REAL DEFAULT 0.0)");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE task ADD COLUMN completion REAL DEFAULT 0.0");
        }
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DoDeck'),),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }, child: Text("Home")),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen(database: _database)));
              }, child: Text("Add Task")),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskDetails(database: _database)));
              }, child: Text("Show Task")),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              }, child: Text("Settings")),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                onPressed: () => logout(context),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: Colors.pink[200]
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(2),
                    width: _isExpanded ? 190 : 170,
                    height: _isExpanded ? 190 : 170,
                    color: Colors.pink,
                    child: Center(
                      child: Text("Welcome",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(2),
                    width: _isExpanded ? 160 : 150,
                    height: _isExpanded ? 160 : 150,
                    color: Colors.pink[300],
                    child: Center(
                      child: Text("Back",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // SOMYA
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: EdgeInsets.all(5),
                width: _isExpanded ? 320 : 300,
                height: 50,
                color: Colors.pink[100],
                child: Center(
                  child: Text(" SOMYA ",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),

              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(2),
                    width: _isExpanded ? 150 : 130,
                    height: _isExpanded ? 150 : 130,
                    color: Colors.pink[400],
                    child: Center(
                      child: Text("Let's",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(1),
                    width: _isExpanded ? 200 : 180,
                    height: _isExpanded ? 200 : 180,
                    color: Colors.pink[800],
                    child: Center(
                      child: Text("Manage",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[100],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Row 3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(2),
                    width: _isExpanded ? 150 : 130,
                    height: _isExpanded ? 270 : 250,
                    color: Colors.pink[100],
                    child: Center(
                      child: Text("Your",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800],
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(2),
                    width: _isExpanded ? 140 : 120,
                    height: _isExpanded ? 190 : 170,
                    color: Colors.pink[500],
                    child: Center(
                      child: Text("Tasks",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            splashColor: Colors.pink[200],
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskScreen(database: _database)),
              );
            },
            child: Icon(Icons.add, color: Colors.pink),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn2',
            splashColor: Colors.pink[200],
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => TaskDetails(database: _database)),
              );
            },
            child: Icon(Icons.visibility, color: Colors.pink),
          ),
        ],
      ),
    );
  }
}













// Future<void> _initDatabase() async {
//   String path = join(await getDatabasesPath(), "task.db");
//
//   _database = await openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) {
//       return db.execute(sqlCreate);
//     },
//   );
// }


//USING PROVIDER THEME

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dodeck_project/theme_provider.dart';
// import 'package:dodeck_project/task_list.dart';
// import 'package:dodeck_project/task_details.dart';
// import 'package:dodeck_project/user_login.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Database _database;
//
//   bool _isExpanded = false;
//
//   Future<void> _initDatabase() async {
//     String path = join(await getDatabasesPath(), "task.db");
//     _database = await openDatabase(
//       path,
//       version: 2,
//       onCreate: (db, version) {
//         db.execute("CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, completion REAL DEFAULT 0.0)");
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           await db.execute("ALTER TABLE task ADD COLUMN completion REAL DEFAULT 0.0");
//         }
//       },
//     );
//   }
//
//   void logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool("is_login", false);
//     Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (_) => const LoginScreen()),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _initDatabase();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('DoDeck')),
//       drawer: Drawer(
//         child: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 40),
//           children: [
//             const Center(child: Text("Select Theme:", style: TextStyle(fontWeight: FontWeight.bold))),
//             ListTile(
//               title: const Text("Light"),
//               onTap: () => themeProvider.setTheme("light" as ThemeData),
//             ),
//             ListTile(
//               title: const Text("Dark"),
//               onTap: () => themeProvider.setTheme("dark" as ThemeData),
//             ),
//             ListTile(
//               title: const Text("Pink"),
//               onTap: () => themeProvider.setTheme("pink" as ThemeData),
//             ),
//             ListTile(
//               title: const Text("Green"),
//               onTap: () => themeProvider.setTheme("green" as ThemeData),
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text("Logout"),
//               onTap: () => logout(context),
//             ),
//           ],
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           setState(() {
//             _isExpanded = !_isExpanded;
//           });
//         },
//         child: Center(
//           child: Text("Welcome to DoDeck!", style: Theme.of(context).textTheme.headlineMedium),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: 'btn1',
//             onPressed: () {
//               Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => AddTaskScreen(database: _database)),
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(height: 10),
//           FloatingActionButton(
//             heroTag: 'btn2',
//             onPressed: () {
//               Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => TaskDetails(database: _database)),
//               );
//             },
//             child: const Icon(Icons.visibility),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
