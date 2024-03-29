import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_chat/cubits/login_cubit/login_cubit.dart';

// Import the generated file
import './firebase_options.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/hola_chat_screen.dart';
import './cubits/signup_cubit/signup_cubit.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
