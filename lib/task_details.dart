
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TaskDetails extends StatefulWidget {
  final Database database;

  TaskDetails({required this.database});

  @override
  State<StatefulWidget> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  List<Map<String, dynamic>> _tasks = [];
  final ScrollController _scrollController = ScrollController();

  //TO FETCH DATA
  Future<void> _fetchTasks() async {
    final List<Map<String, dynamic>> tasks = await widget.database.query('task');
    setState(() {
      _tasks = tasks;
    });
  }

  //TO DELETE TASKS
  Future<void> _deleteTask(int id) async {
    await widget.database.delete('task', where: 'id = ?', whereArgs: [id]);
    _fetchTasks();
  }

  //TO UPDATE TASKS
  Future<void> _updateTask(int id, String myTitle, String myDesc) async {
    await widget.database.update(
      'task',
      {'title': myTitle, 'desc': myDesc},
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchTasks();
  }

  Future<void> _updateTaskCompletion(int id, double completion) async {
    await widget.database.update(
      'task',
      {'completion': completion},
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchTasks();
  }

  void _showUpdateDialog(Map<String, dynamic> task) {
    TextEditingController _editTitleController =
    TextEditingController(text: task['title']);
    TextEditingController _editDescController =
    TextEditingController(text: task['desc']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editTitleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 12,),
                Container(
                  height: 150,
                  child:  TextField(
                    controller: _editDescController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                    ),
                  ) ,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String newTitle = _editTitleController.text.trim();
                String newDesc = _editDescController.text.trim();

                if (newTitle.isNotEmpty && newDesc.isNotEmpty) {
                  await _updateTask(task['id'], newTitle, newDesc);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Both fields are required')),
                  );
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),

      body: _tasks.isEmpty
          ? Center(child: Text("No Tasks Found"))
          : Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(bottom: 80),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            double completion = (_tasks[index]['completion'] ?? 0.0) as double;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _tasks[index]['title'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              _tasks[index]['desc'],
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: completion,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                              minHeight: 6,
                            ),
                            SizedBox(height: 4),
                            Text("Completed: ${(completion * 100).toInt()}%"),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.pink.withOpacity(
                                completion.clamp(0.2, 1.0),
                              ),
                            ),
                            onPressed: () {
                              double newCompletion = (completion + 0.2).clamp(0.0, 1.0);
                              _updateTaskCompletion(_tasks[index]['id'], newCompletion);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              _showUpdateDialog(_tasks[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline_rounded, color: Colors.pink),
                            onPressed: () {
                              _deleteTask(_tasks[index]['id']);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),





      // body: _tasks.isEmpty
      //     ? Center(child: Text("No Tasks Found"))
      //     : Scrollbar(
      //   controller: _scrollController,
      //   thumbVisibility: true,
      //   child: ListView.builder(
      //     controller: _scrollController,
      //     padding: EdgeInsets.only(bottom: 80),
      //     itemCount: _tasks.length,
      //     itemBuilder: (context, index) {
      //       double completion = (_tasks[index]['completion'] ?? 0.0) as double;
      //
      //       return Card(
      //         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      //         elevation: 3,
      //         child: Padding(
      //           padding: const EdgeInsets.all(12.0),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               // Left side (task info)
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       _tasks[index]['title'],
      //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //                     ),
      //                     SizedBox(height: 6),
      //                     Text(
      //                       _tasks[index]['desc'],
      //                       maxLines: 10,
      //                       overflow: TextOverflow.ellipsis,
      //                     ),
      //                     SizedBox(height: 6),
      //                     LinearProgressIndicator(
      //                       value: completion,
      //                       backgroundColor: Colors.grey[300],
      //                       valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
      //                       minHeight: 6,
      //                     ),
      //                     SizedBox(height: 4),
      //                     Text("Completed: ${(completion * 100).toInt()}%"),
      //                   ],
      //                 ),
      //               ),
      //
      //               // Right side (actions)
      //               Column(
      //                 children: [
      //                   IconButton(
      //                     icon: Icon(
      //                       Icons.favorite,
      //                       color: Colors.pink.withOpacity(
      //                         completion.clamp(0.2, 1.0),
      //                       ),
      //                     ),
      //                     tooltip: 'Mark Progress',
      //                     onPressed: () {
      //                       double newCompletion = (completion + 0.2).clamp(0.0, 1.0);
      //                       _updateTaskCompletion(_tasks[index]['id'], newCompletion);
      //                     },
      //                   ),
      //                   IconButton(
      //                     icon: Icon(Icons.edit, color: Colors.grey),
      //                     onPressed: () {
      //                       _showUpdateDialog(_tasks[index]);
      //                     },
      //                   ),
      //                   IconButton(
      //                     icon: Icon(Icons.delete_outline_rounded, color: Colors.pink),
      //                     onPressed: () {
      //                       _deleteTask(_tasks[index]['id']);
      //                     },
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),


      floatingActionButton: FloatingActionButton(
        splashColor: Colors.pink[200],
        child: Icon(Icons.arrow_back, color: Colors.pink),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}




//USING PROVIDER THEME

//import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
//
// class TaskDetails extends StatefulWidget {
//   final Database database;
//
//   const TaskDetails({super.key, required this.database});
//
//   @override
//   State<TaskDetails> createState() => _TaskDetailsState();
// }
//
// class _TaskDetailsState extends State<TaskDetails> {
//   List<Map<String, dynamic>> _tasks = [];
//   final ScrollController _scrollController = ScrollController();
//
//   Future<void> _fetchTasks() async {
//     final List<Map<String, dynamic>> tasks = await widget.database.query('task');
//     setState(() {
//       _tasks = tasks;
//     });
//   }
//
//   Future<void> _deleteTask(int id) async {
//     await widget.database.delete('task', where: 'id = ?', whereArgs: [id]);
//     _fetchTasks();
//   }
//
//   Future<void> _updateTask(int id, String newTitle, String newDesc) async {
//     await widget.database.update(
//       'task',
//       {'title': newTitle, 'desc': newDesc},
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     _fetchTasks();
//   }
//
//   Future<void> _updateTaskCompletion(int id, double completion) async {
//     await widget.database.update(
//       'task',
//       {'completion': completion},
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     _fetchTasks();
//   }
//
//   void _showUpdateDialog(Map<String, dynamic> task) {
//     TextEditingController _title = TextEditingController(text: task['title']);
//     TextEditingController _desc = TextEditingController(text: task['desc']);
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Edit Task'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')),
//               TextField(controller: _desc, decoration: const InputDecoration(labelText: 'Description')),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_title.text.isNotEmpty && _desc.text.isNotEmpty) {
//                   await _updateTask(task['id'], _title.text, _desc.text);
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Fields can't be empty")),
//                   );
//                 }
//               },
//               child: const Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchTasks();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Task Details')),
//       body: _tasks.isEmpty
//           ? const Center(child: Text("No Tasks Found"))
//           : Scrollbar(
//         controller: _scrollController,
//         thumbVisibility: true,
//         child: ListView.builder(
//           controller: _scrollController,
//           itemCount: _tasks.length,
//           itemBuilder: (context, index) {
//             double completion = (_tasks[index]['completion'] ?? 0.0) as double;
//
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Left
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(_tasks[index]['title'],
//                               style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 6),
//                           Text(_tasks[index]['desc']),
//                           const SizedBox(height: 6),
//                           LinearProgressIndicator(
//                             value: completion,
//                             backgroundColor: Colors.grey[300],
//                             valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.secondary),
//                             minHeight: 6,
//                           ),
//                           const SizedBox(height: 4),
//                           Text("Completed: ${(completion * 100).toInt()}%"),
//                         ],
//                       ),
//                     ),
//
//                     // Right
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.favorite,
//                               color: theme.colorScheme.secondary.withOpacity(completion.clamp(0.3, 1.0))),
//                           onPressed: () {
//                             double newCompletion = (completion + 0.2).clamp(0.0, 1.0);
//                             _updateTaskCompletion(_tasks[index]['id'], newCompletion);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => _showUpdateDialog(_tasks[index]),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
//                           onPressed: () => _deleteTask(_tasks[index]['id']),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         splashColor: theme.colorScheme.secondary,
//         child: const Icon(Icons.arrow_back),
//         onPressed: () => Navigator.pop(context),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
//
// class TaskDetails extends StatefulWidget{
//
//   final Database database;
//
//   TaskDetails({required this.database});
//
//   @override
//   State<StatefulWidget> createState() => _TaskDetailsState();
//   }
//
// class _TaskDetailsState extends State<TaskDetails>{
//
//   List<Map<String, dynamic>> _tasks = [];
//
//   Future<void> _fetchTasks() async {
//     final List<Map<String, dynamic>> tasks = await widget.database.query('task');
//     setState(() {
//       _tasks = tasks;
//     });
//   }
//
//   Future<void> _deleteTask(int id) async {
//     await widget.database.delete('task', where: 'id = ?', whereArgs: [id]);
//     _fetchTasks(); // Refresh after delete
//   }
//
//   Future<void> _updateTask(int id, String myTitle, String myDesc) async {
//     await widget.database.update('task',{'title':myTitle, 'desc': myDesc}, where: 'id = ?', whereArgs: [id]);
//     _fetchTasks(); // Refresh after delete
//   }
//
//   void _showUpdateDialog(Map<String, dynamic> task){
//     TextEditingController _titlecontroller = TextEditingController(text: task['title']);
//     TextEditingController _desccontroller = TextEditingController(text: task['desc']);
//
//     showDialog(
//         context: context,
//         builder: (context){
//           return AlertDialog(
//             title: Text('Edit task'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _titlecontroller,
//                   decoration: InputDecoration(labelText: 'Title'),
//                 ),
//                 SizedBox(height: 10,),
//                 TextField(
//                   controller: _desccontroller,
//                   maxLines: 10,
//                   style: TextStyle(color: Colors.pink[300]),
//                   decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//               ElevatedButton(
//                   onPressed: () async{
//                     String newTitle = _titlecontroller.text;
//                     String newDesc = _desccontroller.text;
//
//                     if(newTitle.isNotEmpty && newDesc.isNotEmpty){
//                       await _updateTask(task['id'], newTitle, newDesc);
//                        Navigator.pop(context);
//                     }else{
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Both fields required')),
//                       );
//                     }
//                   }, child: Text('Update'))
//             ],
//           );
//         }
//         );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task can be shown here'),
//       ),
//       body: _tasks.isEmpty
//           ? Center(child: Text("No Tasks Found"))
//           : ListView.builder(
//         itemCount: _tasks.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_tasks[index]['title']),
//             subtitle: Text(_tasks[index]['desc']),
//             trailing: SizedBox(
//               width: 100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.delete, color: Colors.pink[700]),
//                     onPressed: () {
//                       _deleteTask(_tasks[index]['id']);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit, color: Colors.black12),
//                     onPressed: () {
//                       _showUpdateDialog(_tasks[index]);
//                     },
//                   ),
//                 ],
//               )
//             )
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         splashColor: Colors.pink[200],
//         child: Icon(Icons.arrow_back, color: Colors.pink,),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }