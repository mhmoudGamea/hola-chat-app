import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Import the generated file
import './firebase_options.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/hola_chat_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HolaChat());
}

class HolaChat extends StatelessWidget {
  const HolaChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hola Chat',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        LoginScreen.rn: (context) => LoginScreen(),
        SignupScreen.rn: (context) => SignupScreen(),
        HolaChatScreen.rn: (context) => HolaChatScreen(),
      },
    );
  }
}
