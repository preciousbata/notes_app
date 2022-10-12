import 'package:flutter/cupertino.dart';
import 'package:notes_app/screens/add_note_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/sign_in_screen.dart';

import 'screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
HomeScreen.routeName : (context) => const HomeScreen(),
  AddNoteScreen.routeName : (context) => const AddNoteScreen(),
  SplashScreen.routeName : (context) => const SplashScreen(),
  SignIn.routeName: (context) => const SignIn(),
};