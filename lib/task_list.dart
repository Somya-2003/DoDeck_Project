import 'package:dodeck_project/task_details.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddTaskScreen extends StatefulWidget{
  final Database database;
  AddTaskScreen({required this.database});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>{

  TextEditingController _titlecon = TextEditingController();
  TextEditingController _desccon = TextEditingController();

  Future<void> _insertTask(String title, String desc) async{
    await widget.database.insert('task', {'title': title, 'desc': desc});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Task can be added here '),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _titlecon,
                decoration: InputDecoration(
                  icon: Icon(Icons.text_format),
                  iconColor: Colors.pink,
                  border: UnderlineInputBorder(),
                  hintText: "Enter Task Title",
                  fillColor: Colors.pink[200],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _desccon,
                maxLines: 10,
                decoration: InputDecoration(
                  icon: Icon(Icons.text_format),
                  iconColor: Colors.pink,
                  border: OutlineInputBorder(),
                  focusColor: Colors.pink[200],
                  hintText: "Add task description",
                  fillColor: Colors.pink[700],
                ),
              ),

              ElevatedButton(onPressed: () async{
                if(_titlecon.text.isNotEmpty && _desccon.text.isNotEmpty){
                  await _insertTask(_titlecon.text, _desccon.text);
                  _titlecon.clear();
                  _desccon.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Added ')),
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill both fields')),
                  );
                }
              }, child: Text('Add task')),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskDetails(database: widget.database))
                );
              }, child: Text('Show Task')),
            ],
          ),) ,),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.pink[200],
        child: Icon(Icons.arrow_back, color: Colors.pink,),
        onPressed: () {
          Navigator.pop(context);
        },),
    );
  }}








//USING PROVIDER THEME

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:dodeck_project/task_details.dart';
// import 'package:dodeck_project/theme_provider.dart';
//
// class AddTaskScreen extends StatefulWidget {
//   final Database database;
//
//   const AddTaskScreen({super.key, required this.database});
//
//   @override
//   State<AddTaskScreen> createState() => _AddTaskScreenState();
// }
//
// class _AddTaskScreenState extends State<AddTaskScreen> {
//   final TextEditingController _titlecon = TextEditingController();
//   final TextEditingController _desccon = TextEditingController();
//
//   Future<void> _insertTask(String title, String desc) async {
//     await widget.database.insert('task', {'title': title, 'desc': desc});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add a Task'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titlecon,
//                 decoration: InputDecoration(
//                   icon: const Icon(Icons.text_format),
//                   labelText: "Task Title",
//                   border: const UnderlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _desccon,
//                 maxLines: 10,
//                 decoration: const InputDecoration(
//                   icon: Icon(Icons.description),
//                   labelText: "Description",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_titlecon.text.isNotEmpty && _desccon.text.isNotEmpty) {
//                     await _insertTask(_titlecon.text, _desccon.text);
//                     _titlecon.clear();
//                     _desccon.clear();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Task Added')),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please fill both fields')),
//                     );
//                   }
//                 },
//                 child: const Text('Add Task'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => TaskDetails(database: widget.database),
//                     ),
//                   );
//                 },
//                 child: const Text('Show Tasks'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         splashColor: theme.colorScheme.secondary,
//         onPressed: () => Navigator.pop(context),
//         child: const Icon(Icons.arrow_back),
//       ),
//     );
//   }
// }


