import 'package:dodeck_project/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  //final Function(ThemeData) onThemeChange;
 // const _LoginScreenState({super.key, required this.onThemeChange});

  final username = TextEditingController();
  final password = TextEditingController();

  void login() async{
    if(username.text == "Somya" && password.text == "2013"){
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("is_login", true);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid login")),
      );
    }
  }

  @override
   Widget build(BuildContext context){

    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

     return Scaffold(
       appBar: AppBar(
         title: Text('Login Screen'),
         backgroundColor: color,
         foregroundColor: theme.colorScheme.onPrimary,
       ),
       body: SingleChildScrollView(
         child: Padding(padding: const EdgeInsets.all(24),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.account_circle, size: 50, color: Colors.pink,  ),
               TextField(
                 style: theme.textTheme.headlineSmall,
                 controller: username,
                 decoration: InputDecoration(
                   labelText: "Username",
                   focusColor: Colors.pink,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20)
                   ),
                 ),
               ),
               SizedBox(
                 height: 10,
               ),

               TextField(
                 style: theme.textTheme.headlineSmall,
                 controller: password,
                 obscureText: true,
                 decoration: InputDecoration(
                   labelText: "Password",
                   focusColor: Colors.pink,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20)
                   ),
                 ),
               ),
               SizedBox(height: 15,),
               ElevatedButton(onPressed: login , child: Text("Login")),
             ],
           ),
         ),
         ),
       ),
     );
   }
}





//USING PROVIDER THEME
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dodeck_project/theme_provider.dart';
// import 'package:dodeck_project/home.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final username = TextEditingController();
//   final password = TextEditingController();
//
//   void login() async {
//     if (username.text == "Somya" && password.text == "2013") {
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setBool("is_login", true);
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (_) =>  HomeScreen()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Invalid login")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Screen'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Center(
//           child: Column(
//             children: [
//               const Icon(Icons.account_circle, size: 60, color: Colors.pink),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: username,
//                 decoration: const InputDecoration(
//                   labelText: "Username",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: password,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               ElevatedButton(
//                 onPressed: login,
//                 child: const Text("Login"),
//               ),
//               const SizedBox(height: 20),
//               const Text("Select Theme:"),
//               Wrap(
//                 spacing: 10,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () => themeProvider.setTheme("light" as ThemeData),
//                     child: const Text("Light"),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => themeProvider.setTheme("dark" as ThemeData),
//                     child: const Text("Dark"),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => themeProvider.setTheme('pink' as ThemeData),
//                     child: const Text("Pink"),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => themeProvider.setTheme("green" as ThemeData),
//                     child: const Text("Green"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
